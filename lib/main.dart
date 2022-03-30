import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riderbuyers/logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';
import 'package:riderbuyers/presentation/router/app_router.dart';
import 'core/themes/app_theme.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('background message ${message.notification!.body}');
}

late final cameras;
late final firstCamera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  HydratedBlocOverrides.runZoned(
    () {
      runApp(ridebuyers());
    },
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class ridebuyers extends StatelessWidget {
  final AppRouter _appRouter = AppRouter(firstcamera: firstCamera);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginsignupBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: "ridebuyers",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
