import 'package:whatsapp_clone/models/UserContacts.dart';

import 'package:whatsapp_clone/models/api_response.dart';

import '../../../services/contacts_services.dart';

ContactsServices data = ContactsServices();

class ContactsState {
  static Future<List<UserContacts>> contactsList(String userId) async {
    ApiResponse<List<UserContacts>> result = await data.getContacts(userId);

    if (result.error == false) {
      return result.data;
    } else {
      throw result.errorMessage;
    }
  }
}