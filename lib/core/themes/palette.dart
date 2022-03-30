
//palette.dart
import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffDA3726, //0xfff88c9c 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50:  Color(0xffDA3726),//10% a68c71 0xffdf7e8c 0xffa68c71
      100: Color(0xffD13523),//20% 937d64 0xffc6707d 0xff937d64
      200: Color(0xffC03021),//30% 816d58 0xffae626d 0xff816d58
      300: Color(0xffAE2C1E),//40% 6e5e4b 0xff95545e 0xff6e5e4b
      400: Color(0xff9D281B),//50% 5c4e3f 0xff7c464e 0xff5c4e3f
      500: Color(0xff8C2318),//60% 4a3e32 0xff63383e 0xff4a3e32
      600: Color(0xff7A1F15),//70% 372f25 0xff4a2a2f 0xff372f25
      700: Color(0xff691A12),//80% 251f19 0xff321c1f 0xff251f19
      800: Color(0xff57160F),//90% 12100c 0xff190e10 0xff12100c
      900: Color(0xff46120C),//100% #000000 0xff000000
    },
  );
}