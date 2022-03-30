part of 'riderbuyersapi.dart';

class RiderbuyersAPI_OfferResponse extends RiderbuyersAPI {
  static accept(String phone, String password, String appraisalPrice, String dealToken) async {
    try {
      Map<String, String> body = {
        'token': Strings.TOKEN,
        'key': Strings.KEY,
        'reqType': 'UPDATE',
        'trxType': 'DEAL-MOBILE-APPRAISAL',
        'formType': 'MOBILE',
        'type': 'BUY',
        'phone': phone,
        'pwd': password,
        'dealToken': dealToken,
        'accepted': 'true',
        'appraisalPrice' : appraisalPrice
      };
      var response = await RiderbuyersAPI.client.post(
          Uri.parse(Strings.SERVERURI), //https://cp.way.solutions/webRequest/process
          headers: <String, String>{},
          body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (_) {
      print('Error in useform repo : $_');
      return Future.value();
    }
  }
  static decline(String phone, String password, String appraisalPrice, String dealToken) async {
    try {
      Map<String, String> body = {
        'token': Strings.TOKEN,
        'key': Strings.KEY,
        'reqType': 'UPDATE',
        'trxType': 'DEAL-MOBILE-APPRAISAL',
        'formType': 'MOBILE',
        'type': 'BUY',
        'phone': phone,
        'pwd': password,
        'dealToken': dealToken,
        'accepted': 'false',
        'appraisalPrice' : appraisalPrice
      };
      var response = await RiderbuyersAPI.client.post(
          Uri.parse(Strings.SERVERURI), //https://cp.way.solutions/webRequest/process
          headers: <String, String>{},
          body: body);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return decodedResponse;
    } catch (_) {
      print('Error in useform repo : $_');
      return Future.value();
    }
  }
//just return response
}
