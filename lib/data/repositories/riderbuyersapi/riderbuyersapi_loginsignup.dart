part of 'riderbuyersapi.dart';

class RiderbuyersAPI_LoginSignup extends RiderbuyersAPI {
  static signup(String name, String phone, String email, String pwd,
      String deviceToken) async {
    try {
      var response = await RiderbuyersAPI.client.post(
          Uri.parse(Strings.SERVERURI),
          headers: <String, String>{},
          body: <String, String>{
            'token': Strings.TOKEN,
            'key': Strings.KEY,
            'reqType': 'INSERT',
            'trxType': 'LEAD-MOBILE',
            'formType': 'MOBILE',
            'type': 'BUY',
            'name': name,
            'phone': phone,
            'email': email,
            'pwd': pwd,
            'appId': deviceToken,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (_) {
      print('Error in singup repo : $_');
      return Future.value();
    }
  }

  static login(String phone, String pwd, String deviceToken) async {
    try {
      var response = await RiderbuyersAPI.client.post(
          Uri.parse(Strings.SERVERURI),
          headers: <String, String>{},
          body: <String, String>{
            'token': Strings.TOKEN,
            'key': Strings.KEY,
            'reqType': 'UPDATE',
            'trxType': 'LEAD-MOBILE',
            'formType': 'MOBILE',
            'type': 'BUY',
            'phone': phone,
            'pwd': pwd,
            'appId': deviceToken
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (_) {
      print('Error in singup repo : $_');
      return Future.value();
    }
  }
//just return response
}
