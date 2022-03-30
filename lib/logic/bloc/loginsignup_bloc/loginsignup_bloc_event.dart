part of 'loginsignup_bloc.dart';

abstract class LoginsignupBlocEvent {
  const LoginsignupBlocEvent();
}

class Login extends LoginsignupBlocEvent {
  const Login({required this.phoneno, required this.password, required this.deviceToken, required this.dealPresent, required this.dealToken, required this.make, required this.model, required this.year, required this.kilometres, required this.vin});
  final String phoneno;
  final String password;
  final String deviceToken;
  final bool dealPresent;
  final String dealToken;
  final String make;
  final String model;
  final String year;
  final String kilometres;
  final String vin;

  String get getphoneno {
    return phoneno;
  }

  String get getpassword {
    return password;
  }

  String get getDeviceToken {
    return deviceToken;
  }

  bool get getdealPresent {
    return dealPresent;
  }

  String get getdealToken {
    return dealToken;
  }

  String get getmake {
    return make;
  }
  String get getmodel{
    return model;
  }
  String get getyear{
    return year;
  }
  String get getkilometres {
    return kilometres;
  }
  String get getvin {
    return vin;
  }


}

class Logout extends LoginsignupBlocEvent {}

class Signup extends LoginsignupBlocEvent {
  const Signup(
      {required this.name,
      required this.email,
      required this.phoneno,
      required this.password,
      required this.deviceToken,
      required this.dealPresent,
      required this.dealToken});

  final String name;
  final String email;
  final String phoneno;
  final String password;
  final String deviceToken;
  final bool dealPresent;
  final String dealToken;

  String get getname {
    return name;
  }

  String get getemail {
    return email;
  }

  String get getphoneno {
    return phoneno;
  }

  String get getpassword {
    return password;
  }

  String get getDeviceToken {
    return deviceToken;
  }

  bool get getdealPresent {
    return dealPresent;
  }

  String get getdealToken {
    return dealToken;
  }
}
