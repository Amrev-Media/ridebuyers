import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:riderbuyers/core/constants/strings.dart';
import 'package:riderbuyers/data/models/userform.dart';

part 'riderbuyersapi_loginsignup.dart';
part 'riderbuyersapi_userform.dart';
part 'riderbuyersapi_offerresponse.dart';

abstract class RiderbuyersAPI {
  static var client = http.Client();

  static connect() async {

  }

  static disconnect() async {
    client.close();
  }
}