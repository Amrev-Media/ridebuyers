// To parse this JSON data, do
//
//     final userform = userformFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Userform userformFromMap(String str) => Userform.fromMap(json.decode(str));

String userformToMap(Userform data) => json.encode(data.toMap());

class Userform {
  Userform({
    required this.make,
    required this.model,
    required this.year,
    required this.kilometres,
    required this.vin,
    required this.vImage,
    required this.notes,
  });

  String make;
  String model;
  String year;
  String kilometres;
  String vin;
  List<String> vImage;
  String notes;

  Userform copyWith({
    String? make,
    String? model,
    String? year,
    String? kilometres,
    String? vin,
    List<String>? vImage,
  }) =>
      Userform(
          make: make ?? this.make,
          model: model ?? this.model,
          year: year ?? this.year,
          kilometres: kilometres ?? this.kilometres,
          vin: vin ?? this.vin,
          vImage: vImage ?? this.vImage,
          notes: notes);

  factory Userform.fromMap(Map<String, dynamic> json) => Userform(
      make: json["make"],
      model: json["model"],
      year: json["year"],
      kilometres: json["kilometres"],
      vin: json["vin"],
      vImage: List<String>.from(json["v_image"].map((x) => x)),
      notes: "");

  Map<String, dynamic> toMap() => {
        "make": make,
        "model": model,
        "year": year,
        "kilometres": kilometres,
        "vin": vin,
        "v_image": List<dynamic>.from(vImage.map((x) => x)),
        "notes": notes
      };
}
