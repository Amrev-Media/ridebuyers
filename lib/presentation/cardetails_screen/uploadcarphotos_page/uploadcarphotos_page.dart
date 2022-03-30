import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadCarPhotos_Page extends StatefulWidget {
  const UploadCarPhotos_Page({
    Key? key, required this.loadnext,required this.controller
  }) : super(key: key);

  final Function loadnext;
  final CameraController controller;

  @override
  State<UploadCarPhotos_Page> createState() => _UploadCarPhotos_PageState();
}

class _UploadCarPhotos_PageState extends State<UploadCarPhotos_Page> {
  @override
  bool showcamera = false;
  Widget build(BuildContext context) {
    return (showcamera == false)?
    Column(
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
        SizedBox(height: 20,),
        const Text(
          "Upload CAR Photos",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
                child: Image.asset(
                  'lib/core/assets/images/6_car_frontview.jpg',
                  fit: BoxFit.contain,
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await widget.controller.setFlashMode(FlashMode.off);
                }
                catch(_){
                  print("Device does not have flash capabilities.");
                }
                setState(() {
                  showcamera = true;
                });
              },
              child: Image.asset(
                'lib/core/assets/images/buttons/upload_button_icon.jpg',
                width: 110,
              ),
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                primary: Palette.kToDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ],
    ):displayCameraUI(context, widget.controller, "lib/core/assets/images/svg/carfrontview.svg");
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
                      final image = await controller.takePicture();
                      widget.loadnext(image.path);
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
