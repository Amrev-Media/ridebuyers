import 'dart:async';
import 'dart:ui';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riderbuyers/data/models/userform.dart';
import 'package:riderbuyers/data/repositories/riderbuyersapi/riderbuyersapi.dart';
import 'package:riderbuyers/logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';
import 'package:riderbuyers/presentation/cardetails_screen/carbackview_page/carbackview_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/carbackviewclicked_page/carbackviewClicked_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/cardetails_page/cardetails_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/carrightview_page/carrightview_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/carrightviewclicked_page/carrightviewClicked_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/cartireview_page/cartireview_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/cartireviewclicked_page/cartireviewClicked_page.dart';
import 'package:riderbuyers/presentation/cardetails_screen/uploadcarphotos_page/uploadcarphotos_page.dart';

import 'carfrontviewclicked_page/carfrontviewClicked_page.dart';
import 'carleftview_page/carrightview_page.dart';
import 'carleftviewclicked_page/carleftviewClicked_page.dart';
import 'carmeterview_page/carmeterview_page.dart';
import 'carmeterviewclicked_page/carmeterviewClicked_page.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({Key? key, required this.firstcamera})
      : super(key: key);

  final firstcamera;

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

//Added Filter
class _CarDetailsScreenState extends State<CarDetailsScreen>
    with WidgetsBindingObserver {
  int _pageindex = 0;
  late Userform userform;
  late CameraController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_pageindex == 0)
                CarDetails_Page(
                  loadnext: (Userform currentuserform) {
                    userform = currentuserform;
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                ),
              if (_pageindex == 1)
                UploadCarPhotos_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 2)
                CarfrontViewClicked_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.removeLast();
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  userform: userform,
                  controller: controller,
                ),
              if (_pageindex == 3)
                CarBackView_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 4)
                CarbackViewClicked_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.removeLast();
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  userform: userform,
                  controller: controller,
                ),
              if (_pageindex == 5)
                CarRightView_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 6)
                CarrightViewClicked_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.removeLast();
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  userform: userform,
                  controller: controller,
                ),
              if (_pageindex == 7)
                CarLeftView_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 8)
                CarleftViewClicked_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.removeLast();
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  userform: userform,
                  controller: controller,
                ),
              if (_pageindex == 9)
                CarTireView_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 10)
                CarTireViewClicked_Page(
                    loadnext: (String frontImage) {
                      userform.vImage.removeLast();
                      userform.vImage.add(frontImage);
                      setState(() {
                        _pageindex = _pageindex + 1;
                      });
                    },
                    userform: userform,
                    controller: controller),
              if (_pageindex == 11)
                CarMeterView_Page(
                  loadnext: (String frontImage) {
                    userform.vImage.add(frontImage);
                    setState(() {
                      _pageindex = _pageindex + 1;
                    });
                  },
                  controller: controller,
                ),
              if (_pageindex == 12)
                CarMeterViewClicked_Page(
                  loadnext: (String frontImage) async {
                    userform.vImage.removeLast();
                    userform.vImage.add(frontImage);
                    if (BlocProvider.of<LoginsignupBloc>(context)
                            .state
                            .dealPresent ==
                        true) {
                      dynamic response =
                          await RiderbuyersAPI_Userform.senddealuserform(
                        userform,
                        BlocProvider.of<LoginsignupBloc>(context).state.phone,
                        BlocProvider.of<LoginsignupBloc>(context)
                            .state
                            .password,
                        BlocProvider.of<LoginsignupBloc>(context)
                            .state
                            .dealToken,
                      );
                      //setState(() {});
                      print(response);
                      if (response['success'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 800),
                            content: Text('Details Submitted Successfully.'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 800),
                            content: Text('Failed to Submit Details.'),
                          ),
                        );
                      }
                      Navigator.pushNamed(context, '/welcome_screen');
                    } else {
                      Map<String, dynamic> response =
                          await RiderbuyersAPI_Userform.senduserform(
                              userform,
                              BlocProvider.of<LoginsignupBloc>(context)
                                  .state
                                  .phone,
                              BlocProvider.of<LoginsignupBloc>(context)
                                  .state
                                  .password);
                      //setState(() {});
                      print(response);
                      if (response.containsKey('success')) {
                        if (response['success'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 800),
                              content: Text('Details Submitted Successfully.'),
                            ),
                          );
                          LoginsignupBloc loginsignupbloc =
                              BlocProvider.of<LoginsignupBloc>(context);
                          loginsignupbloc.add(Login(
                              phoneno: loginsignupbloc.state.phone,
                              password: loginsignupbloc.state.password,
                              deviceToken: response['dealToken'],
                              dealPresent: true,
                              dealToken: "",
                              make: "",
                              model: "",
                              year: "",
                              kilometres: "",
                              vin: ""));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 800),
                              content: Text('Failed to Submit Details.'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 800),
                            content: Text('Failed to Submit Details.'),
                          ),
                        );
                      }
                      Navigator.pushNamed(context, '/welcome_screen');
                    }
                  },
                  userform: userform,
                  controller: controller,
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
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
    if (BlocProvider.of<LoginsignupBloc>(context).state.dealPresent == true) {
      _pageindex = 1;
      userform = Userform(
          make: BlocProvider.of<LoginsignupBloc>(context).state.make,
          model: BlocProvider.of<LoginsignupBloc>(context).state.model,
          year: BlocProvider.of<LoginsignupBloc>(context).state.year,
          kilometres:
              BlocProvider.of<LoginsignupBloc>(context).state.kilometres,
          vin: BlocProvider.of<LoginsignupBloc>(context).state.vin,
          vImage: [],
          notes: BlocProvider.of<LoginsignupBloc>(context).state.notes);
    }
    controller = CameraController(
      widget.firstcamera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    // App state changed before we got the chance to initialize.
    if (!controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    BackButtonInterceptor.remove(backInterceptor);
    controller.dispose();
    super.dispose();
  }
}
