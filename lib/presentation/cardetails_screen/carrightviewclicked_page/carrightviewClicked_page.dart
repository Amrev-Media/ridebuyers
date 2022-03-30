import 'dart:io';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:riderbuyers/data/models/userform.dart';

class CarrightViewClicked_Page extends StatefulWidget {
  const CarrightViewClicked_Page({
    Key? key, required this.loadnext, required this.userform, required this.controller
  }) : super(key: key);

  final Function loadnext;
  final Userform userform;
  final CameraController controller;

  @override
  State<CarrightViewClicked_Page> createState() => _CarrightViewClicked_PageState();
}

class _CarrightViewClicked_PageState extends State<CarrightViewClicked_Page> {
  bool showcamera = false;
  @override
  Widget build(BuildContext context) {
    return (showcamera == false)? Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 45, 10, 20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.keyboard_backspace,
                  size: 35,
                  color: Colors.black,
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pushNamed(context, '/welcome_screen');
                },
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  size: 27,
                  color: Colors.black,
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text('No new Notifications.'),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Upload CAR Photos",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Center(
                      child: Image.asset(
                        'lib/core/assets/images/8_car_frontview_clicked.jpg',
                        fit: BoxFit.contain,
                      )),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      width: double.infinity,
                      child: Image.memory(
                        File(widget.userform.vImage.last).readAsBytesSync(),
                        height: 400,
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "RIGHT VIEW",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await widget.controller.setFlashMode(FlashMode.off);
                              setState(() {
                                showcamera = true;
                              });
                            },
                            child: Image.asset(
                              'lib/core/assets/images/buttons/whiteupload_button_icon.jpg',
                              width: 150,
                            ),
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0.0,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: () {
                              widget.loadnext(widget.userform.vImage.last);
                            },
                            child: Image.asset(
                              'lib/core/assets/images/buttons/save&next_button_icon.jpg',
                              width: 130,
                            ),
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              primary: Palette.kToDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],),
        )
      ],
    ):displayCameraUI(context, widget.controller, "lib/core/assets/images/svg/carrightview.svg");
  }

  // A widget that displays the picture taken by the user.
  Widget displayCameraUI(BuildContext context,CameraController controller, String svgoverlay){
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
              child: CameraPreview(controller)),
          Container(
            child: Center(
                child: SvgPicture.asset(
                  svgoverlay,width: 400,
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
                    HapticFeedback.mediumImpact();
                    final image = await controller.takePicture(); print(image.path);
                    widget.userform.vImage.removeLast();
                    widget.userform.vImage.add(image.path);
                    setState(() {
                      showcamera = false;
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
    );
  }

  Future<bool> backInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    if(showcamera == true){
      setState(() {
        showcamera = false;
      });
    }
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
