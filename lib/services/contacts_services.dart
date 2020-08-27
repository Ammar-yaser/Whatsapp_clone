import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:whatsapp_clone/models/User_Model.dart';
import '../models/api_response.dart';
import '../models/UserContacts.dart';

final Firestore _db = Firestore.instance;

class ContactsServices {
  final String _users = 'users';
  final String _contacts = 'contacts';

  Future<ApiResponse<List<UserContact>>> getContacts(String docId) {
    Future<ApiResponse<List<UserContact>>> response = _db
        .collection(_users)
        .document(docId)
        .collection(_contacts)
        .getDocuments()
        .then((result) {
      List<UserContact> contactsList = result.documents.map(
        (doc) {
          return UserContact.fromJson(doc.data);
        },
      ).toList();
      return ApiResponse<List<UserContact>>(
        data: contactsList,
        error: false,
      );
    }).catchError((e) {
      return ApiResponse(error: true, errorMessage: 'Error: $e');
    });
    return response;
  }

  Future<List<UserContact>> contactsListOnDB() async {
    bool status = await Permission.contacts.request().isGranted;
    List<UserContact> contactsList = List();
    Future<void> result;

    if (status) {
      Iterable<Contact> allContacts =
          await ContactsService.getContacts(withThumbnails: false);
      List<Contact> contacts = allContacts.toList();

      contacts.forEach((contact) {
        List<Item> phones = contact.phones.toList();
        String mobile = phones.isNotEmpty ? phones.first.value : '';

        if (mobile != '') {
          result = checkContactOnDB(mobile).then((response) {
            if (response.error == false) {
              contactsList.add(
                UserContact(
                  name: contact.displayName,
                  mobile: mobile,
                  contactId: response.data.userId,
                  imgUrl: response.data.imgUrl,
                  about: response.data.about,
                ),
              );
            }
          });
        }
      });
    }

    return result.then((_) {
      return contactsList;
    });
  }

  Future<ApiResponse<User>> checkContactOnDB(String mobile) async {
    if (mobile.length == 11) {
      mobile = "+2$mobile";
    } else if (mobile.length == 12) {
      mobile = "+$mobile";
    }

    ApiResponse<User> response = await _db
        .collection(_users)
        .where('phone', isEqualTo: "$mobile")
        .getDocuments()
        .then((data) {
      if (data.documents.length != 0) {
        return ApiResponse<User>(
            data: User.fromJson(data.documents[0].data), error: false);
      } else {
        return ApiResponse<User>(error: true, errorMessage: 'not exist');
      }
    }).catchError((e) {
      return ApiResponse<User>(error: true, errorMessage: 'Error $e');
    });

    return response;
  }

  
  Future<void> saveContactOnChatContacts(
      String userId, UserContact contactData) async {
    try {
      await _db
          .collection(_users)
          .document(userId)
          .collection(_contacts)
          .document(contactData.contactId)
          .setData(contactData.toMap());
    } catch (e) {
      print("error: $e");
    }
  }
}
