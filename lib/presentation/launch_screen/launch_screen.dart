import 'dart:async';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riderbuyers/logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';

class LaunchScreen extends StatefulWidget {
  LaunchScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  late FirebaseMessaging messaging;

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with WidgetsBindingObserver {
  bool storagepermissionGranted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
                child: Image.asset(
              'lib/core/assets/images/1_splash.jpg',
              fit: BoxFit.fitHeight,
            )),
          ),
        ],
      ),
    );
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        storagepermissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      setState(() {
        storagepermissionGranted = false;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _getStoragePermission().whenComplete(() {
      if (storagepermissionGranted == true) {
        if (BlocProvider.of<LoginsignupBloc>(context).state.status ==
            LoginsignupStatus.authenticated) {
          Navigator.pushNamed(context, '/welcome_screen');
        } else {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushNamed(context, '/loginsignup_screen');
          });
        }
      }
    });
    widget.messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.data);
      if (event.data.containsKey('price')) {
        Navigator.pushNamed(
          context,
          '/notification_screen',
          arguments: event.data['price'],
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print('Message clicked!');
      if (event.data.containsKey('price')) {
        Navigator.pushNamed(
          context,
          '/notification_screen',
          arguments: event.data['price'],
        );
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => print(value));
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
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
