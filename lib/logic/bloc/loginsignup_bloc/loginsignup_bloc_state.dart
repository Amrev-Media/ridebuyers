part of 'loginsignup_bloc.dart';

enum LoginsignupStatus {
  initial,
  loggingin,
  signingin,
  authenticated,
  unauthenticated,
  serviceunavailable
}
enum LoginsignupErrorStatus {
  initial,
  success,
  error,
}

class LoginsignupBlocState extends Equatable {
  const LoginsignupBlocState(
      {this.status = LoginsignupStatus.initial,
      this.errorstatus = LoginsignupErrorStatus.initial,
      this.name = "",
      this.phone = "",
      this.password = "",
      this.email = "",
      this.dealPresent = false,
      this.dealToken = "",
      this.make = "",
      this.model = "",
      this.year = "",
      this.kilometres = "",
      this.vin = "",
      this.notes = ""});

  final LoginsignupStatus status;
  final LoginsignupErrorStatus errorstatus;
  final String name;
  final String phone;
  final String password;
  final String email;
  final bool dealPresent;
  final String dealToken;
  final String make;
  final String model;
  final String year;
  final String kilometres;
  final String vin;
  final String notes;

  LoginsignupBlocState copyWith(
      {LoginsignupStatus? status,
      LoginsignupErrorStatus? errorstatus,
      String? name,
      String? phone,
      String? password,
      String? email,
      bool? dealPresent,
      String? dealToken,
      String? make,
      String? model,
      String? year,
      String? kilometres,
      String? vin,
      String? notes}) {
    return LoginsignupBlocState(
        status: status ?? this.status,
        errorstatus: errorstatus ?? this.errorstatus,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        email: email ?? this.email,
        dealPresent: dealPresent ?? this.dealPresent,
        dealToken: dealToken ?? this.dealToken,
        make: make ?? this.make,
        model: model ?? this.model,
        year: year ?? this.year,
        kilometres: kilometres ?? this.kilometres,
        vin: vin ?? this.vin,
        notes: notes ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.index,
      //'errorstatus' : errorstatus,
      'name': name,
      'phone': phone,
      'password': password,
      'email': email,
      'dealPresent': dealPresent,
      'dealToken': dealToken,
      'make': make,
      'model': model,
      'year': year,
      'kilometres': kilometres,
      'vin': vin,
      'notes': notes
    };
  }

  factory LoginsignupBlocState.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) return const LoginsignupBlocState();

    return LoginsignupBlocState(
        status: LoginsignupStatus.values[map['status']],
        //errorstatus: map['errorstatus'],
        name: map['name'],
        phone: map['phone'],
        password: map['password'],
        email: map['email'],
        dealPresent: map['dealPresent'],
        dealToken: map['dealToken'],
        make: map['make'],
        model: map['model'],
        year: map['year'],
        kilometres: map['kilometres'],
        vin: map['vin']);
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory LoginsignupBlocState.fromJson(String source) {
    return LoginsignupBlocState.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return '''LoginsignupBlocState { status: $status, errorstatus: $errorstatus, name: $name, phone: $phone, password: $password, email: $email, dealPresent: $dealPresent, dealToken: $dealToken, make: $make, model: $model, year: $year, kilometres: $kilometres, vin: $vin}''';
  }

  @override
  List<Object> get props => [
        status,
        errorstatus,
        name,
        phone,
        email,
        dealPresent,
        dealToken,
        make,
        model,
        year,
        kilometres,
        vin
      ];
}
