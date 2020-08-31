import 'package:whatsapp_clone/models/UserContacts.dart';

import 'package:whatsapp_clone/models/api_response.dart';

import '../../../services/contacts_services.dart';

ContactsServices data = ContactsServices();

class ContactsState {

  Future<List<UserContact>> chatsList(String userId) async {
    ApiResponse<List<UserContact>> result = await data.getContacts(userId);

    if (result.error == false) {
      return result.data;
    } else {
      throw result.errorMessage;
    }
  }

  Future<List<UserContact>> contacts() async {
    List<UserContact> contactsFromDB = await data.contactsListOnDB();
    
    return contactsFromDB;
  }


}
