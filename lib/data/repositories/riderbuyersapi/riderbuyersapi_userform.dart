part of 'riderbuyersapi.dart';

class RiderbuyersAPI_Userform extends RiderbuyersAPI {
  static senduserform(Userform userform, String phone, String password) async {
    try {
      Map<String, String> body = {
        'token': Strings.TOKEN,
        'key': Strings.KEY,
        'reqType': 'INSERT',
        'trxType': 'DEAL-MOBILE',
        'formType': 'MOBILE',
        'type': 'BUY',
        'phone': phone,
        'pwd': password,
        'make': userform.make,
        'model': userform.model,
        'year': userform.year,
        'kilometres': userform.kilometres,
        'vin': userform.vin,
        'notes': userform.notes
      };
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(Strings.SERVERURI),
      );
      request.headers["Content-Type"] = "application/json";
      request.fields.addAll(body);
      for (var i = 0; i < 6; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('v_image', userform.vImage[i]));
      }
      http.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      var decodedResponse = jsonDecode(responseString);
      return decodedResponse;
    } catch (_) {
      print('Error in useform repo : $_');
      return Future.value();
    }
  }

  static senddealuserform(Userform userform, String phone, String password,
      String dealToken) async {
    try {
      Map<String, String> body = {
        'token': Strings.TOKEN,
        'key': Strings.KEY,
        'reqType': 'UPDATE',
        'trxType': 'DEAL-MOBILE',
        'formType': 'MOBILE',
        'type': 'BUY',
        'phone': phone,
        'pwd': password,
        'dealToken': dealToken,
        'make': userform.make,
        'model': userform.model,
        'year': userform.year,
        'kilometres': userform.kilometres,
        'vin': userform.vin,
      };
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(Strings.SERVERURI),
      );
      request.headers["Content-Type"] = "application/json";
      request.fields.addAll(body);
      for (var i = 0; i < 6; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('v_image', userform.vImage[i]));
      }
      http.StreamedResponse response = await request.send();
      var responseString = await response.stream.bytesToString();
      var decodedResponse = jsonDecode(responseString);
      return decodedResponse;
    } catch (_) {
      print('Error in useform repo : $_');
      return Future.value();
    }
  }
//just return response
}
