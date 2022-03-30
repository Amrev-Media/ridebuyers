import 'dart:async';
import 'dart:ui';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:riderbuyers/data/repositories/riderbuyersapi/riderbuyersapi.dart';

import '../../logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

//Added Filter
class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final dynamic offerprice = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.pushNamed(
                          context,
                          '/welcome_screen',
                        );
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {},
                      child: Image.asset(
                        "lib/core/assets/images/buttons/new_notification_icon.jpg",
                        width: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0.0,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 30, 0, 30),
                child: Text("Notification",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              Container(
                child: Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                            child: Image.asset(
                          'lib/core/assets/images/21_notification.jpg',
                          fit: BoxFit.contain,
                        )),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 40,
                      child: Column(
                        children: [
                          const Text(
                            "You've received a Quote on \nyour car of ",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    RiderbuyersAPI_OfferResponse.accept(
                                        BlocProvider.of<LoginsignupBloc>(
                                                context)
                                            .state
                                            .phone,
                                        BlocProvider.of<LoginsignupBloc>(
                                                context)
                                            .state
                                            .password,
                                        offerprice,
                                        "dealToken");
                                  },
                                  child: Image.asset(
                                    'lib/core/assets/images/buttons/accept_notification_icon.jpg',
                                    width: 130,
                                    height: 22,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    primary: Palette.kToDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    RiderbuyersAPI_OfferResponse.decline(
                                        BlocProvider.of<LoginsignupBloc>(
                                                context)
                                            .state
                                            .phone,
                                        BlocProvider.of<LoginsignupBloc>(
                                                context)
                                            .state
                                            .password,
                                        offerprice,
                                        "dealToken");
                                  },
                                  child: Image.asset(
                                    'lib/core/assets/images/buttons/decline_notification_icon.jpg',
                                    width: 150,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                    elevation: 0.0,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    primary: Colors.white,
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
                    Positioned(
                      bottom: 0,
                      left: 180,
                      top: 72,
                      child: Text(
                        "\$$offerprice",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Palette.kToDark),
                      ),
                    ),
                  ],
                ),
              )
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
    super.initState();
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
  }
}
