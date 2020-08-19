import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/api_response.dart';
import '../models/UserContacts.dart';

final Firestore _db = Firestore.instance;

class ContactsServices {
  final String _users = 'users';
  final String _contacts = 'contacts';

  Future<ApiResponse<List<UserContacts>>> getContacts(String docId) {
    Future<ApiResponse<List<UserContacts>>> response = _db
        .collection(_users)
        .document(docId)
        .collection(_contacts)
        .getDocuments()
        .then((result) {
      List<UserContacts> contactsList = result.documents.map((doc) {
        return UserContacts.fromJson(doc.data);
      },).toList();
      return ApiResponse<List<UserContacts>>(
        data: contactsList,
        error: false,
      );
    }).catchError((e) {
      return ApiResponse(error: true, errorMessage: 'Error: $e');
    });
    return response;
  }
}
