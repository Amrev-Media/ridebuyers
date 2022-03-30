import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:riderbuyers/logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';

class TestScreen extends StatefulWidget {
  TestScreen({Key? key, required this.firstcamera}) : super(key: key);

  final firstcamera;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

//Added Filter
class _TestScreenState extends State<TestScreen> with WidgetsBindingObserver {
  late CameraController controller;
  bool clicked = false;
  String imagepath = "";
  @override
  Widget build(BuildContext context) {
    return (clicked == false)?displayCameraUI(context, controller, "lib/core/assets/images/svg/carfrontview.svg"):displayPictureScreen(imagepath);
  }

  // A widget that displays the picture taken by the user.
  Widget displayPictureScreen(String imagePath) {
    return Image.file(File(imagePath));
  }

// A widget that displays the picture taken by the user.
  Widget displayCameraUI(BuildContext context,CameraController controller, String svgoverlay){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            Container(
                child: CameraPreview(controller)),
            Container(
              child: Center(
                  child: SvgPicture.asset(
                    "lib/core/assets/images/svg/carbackview.svg",
                  )),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final image = await controller.takePicture();
                      imagepath = image.path;
                      clicked = true;
                      setState(() {

                      });
                    },
                    child: Image.asset(
                      'lib/core/assets/images/buttons/clickcamera.jpg',
                      width: 90,
                    ),
                    style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        primary: Colors.transparent,
                        elevation: 0
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> backInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    //Do nothing here
    return true;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    BackButtonInterceptor.add(backInterceptor);
    super.initState();
    controller = CameraController(widget.firstcamera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.paused) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
    controller.dispose();
  }
}