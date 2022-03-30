import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:riderbuyers/data/models/userform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarDetails_Page extends StatefulWidget {
  CarDetails_Page({
    Key? key,
    required this.loadnext,
  }) : super(key: key);

  final Function loadnext;

  @override
  State<CarDetails_Page> createState() => _CarDetails_PageState();
}

List<String> getYearsList() {
  int year = DateTime.now().year;
  List<String> yearList = [];
  for (int i = year; i > year - 30; i--) {
    yearList.add(i.toString());
  }
  return yearList;
}

class _CarDetails_PageState extends State<CarDetails_Page> {
  String year = DateTime.now().year.toString();
  String kilometres = "",
      make = "",
      model = "",
      vin = "",
      cylinders = "",
      fuelType = "",
      mileage = "",
      exteriorColor = "",
      interiorColor = "",
      hasAccident = "No",
      transmission = "Manual";
  List<String> yearList = getYearsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Center(
              child: Image.asset(
            'lib/core/assets/images/5_car_details.jpg',
            fit: BoxFit.fitWidth,
          )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add your CAR details",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "MAKE",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.car_repair),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      make = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "MODEL",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.settings_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      model = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    value: year,
                    decoration: const InputDecoration(
                      label: Text(
                        "YEAR",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        year = newValue!;
                      });
                    },
                    items:
                        yearList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "KILOMETERS",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.social_distance),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      kilometres = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "CYLINDERS",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.account_tree_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      cylinders = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "FUEL TYPE",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.airport_shuttle_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      fuelType = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "MILEAGE",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.add_road),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      mileage = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "Exterior Color",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.format_color_fill_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      exteriorColor = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text(
                        "Interior Color",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.format_color_fill_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (data) {
                      interiorColor = data;
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    value: hasAccident,
                    decoration: const InputDecoration(
                      label: Text(
                        "HAS ACCIDENT",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.no_transfer_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        hasAccident = newValue!;
                      });
                    },
                    items: ['Yes', 'No']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 300,
                  child: DropdownButtonFormField(
                    value: transmission,
                    decoration: const InputDecoration(
                      label: Text(
                        "TRANSMISSION",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: Icon(Icons.airport_shuttle_outlined),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        transmission = newValue!;
                      });
                    },
                    items: ['Automatic', 'Manual']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Userform userform = Userform(
                    make: make,
                    model: model,
                    year: year,
                    kilometres: kilometres,
                    vin: vin,
                    vImage: [],
                    notes:
                        "Cylinders: $cylinders <br> Fuel Type: $fuelType <br> Mileage: $mileage <br> Exterior Color: $exteriorColor <br> Interior Color: $interiorColor <br> Has Accident: $hasAccident <br> Transmission: $transmission <br>");
                widget.loadnext(userform);
              },
              child: Image.asset(
                'lib/core/assets/images/buttons/submit_button_icon.jpg',
                width: 90,
              ),
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                primary: Palette.kToDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> backInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(backInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
  }
}
