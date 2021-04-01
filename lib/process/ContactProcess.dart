import 'package:doctor/network/ApiResponse.dart';
import 'package:doctor/network/Apis.dart';
import 'package:doctor/network/NetworkCalls.dart';

class ContactProcess{

  getAllContacts(void inner(ApiResponse apiResponse)) {

    NetworkCalls().forRequest((apiResponce) {
      inner(apiResponce);

    }, Apis.GET_CONTACTS, RequestType.GET,);
  }

}