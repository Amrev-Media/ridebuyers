import 'dart:async';
import 'dart:ui';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:riderbuyers/core/themes/palette.dart';
import 'package:riderbuyers/logic/bloc/loginsignup_bloc/loginsignup_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum pages {
  login,
  signup,
}

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

//Added Filter
class _LoginSignupScreenState extends State<LoginSignupScreen>
    with WidgetsBindingObserver {
  pages currentPage = pages.login;
  String name = "";
  String email = "";
  String phoneno = "";
  String password = "";
  String confirmpassword = "";
  String deviceToken = "";
  bool passwordshow = false;
  var phoneNumberFormatter = MaskTextInputFormatter(mask: '(###) ###-####');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginsignupBloc, LoginsignupBlocState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: (currentPage == pages.login)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Center(
                                child: Image.asset(
                              'lib/core/assets/images/3_login.jpg',
                              fit: BoxFit.fitWidth,
                            )),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Log in",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                const Text(
                                  "Please sign in to continue.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [phoneNumberFormatter],
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "PHONE",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon:
                                            Icon(Icons.local_phone_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        phoneno = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      obscureText: !passwordshow,
                                      decoration: InputDecoration(
                                        label: const Text(
                                          "PASSWORD",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon: Icon(Icons.lock_outlined),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1)),
                                        suffix: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              passwordshow = !passwordshow;
                                            });
                                          },
                                          child: Text(
                                            (passwordshow) ? "Hide" : "Show",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Palette.kToDark),
                                          ),
                                        ),
                                      ),
                                      onChanged: (data) {
                                        password = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 40,
                                ),
                                (state.status == LoginsignupStatus.loggingin)
                                    ? const CircularProgressIndicator()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (phoneno.length < 10) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Phone Number Incomplete.'),
                                                  ),
                                                );
                                              } else if (password.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content:
                                                        Text('Enter Password.'),
                                                  ),
                                                );
                                              } else {
                                                BlocProvider.of<
                                                            LoginsignupBloc>(
                                                        context)
                                                    .add(Login(
                                                        phoneno: phoneno,
                                                        password: password,
                                                        deviceToken:
                                                            deviceToken,
                                                        dealPresent: false,
                                                        dealToken: "",
                                                        make: "",
                                                        model: "",
                                                        year: "",
                                                        kilometres: "",
                                                        vin: ""));
                                              }
                                            },
                                            child: Image.asset(
                                              'lib/core/assets/images/buttons/login_button_icon.jpg',
                                              width: 90,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 10, 15, 10),
                                              primary: Palette.kToDark,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an Account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: () {
                                  phoneno = '';
                                  password = '';
                                  setState(() {
                                    currentPage = pages.signup;
                                  });
                                },
                                child: const Text(
                                  " Sign up",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Palette.kToDark),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Center(
                                child: Image.asset(
                              'lib/core/assets/images/2_signup.jpg',
                              fit: BoxFit.fitWidth,
                            )),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "FULL NAME",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon:
                                            Icon(Icons.assignment_ind_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        name = data;
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
                                          "EMAIL",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon: Icon(Icons.email_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        email = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [phoneNumberFormatter],
                                      maxLength: 14,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "PHONE NO",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon:
                                            Icon(Icons.local_phone_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        phoneno = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "PASSWORD",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon: Icon(Icons.lock_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        password = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    width: 300,
                                    child: TextField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          "CONFIRM PASSWORD",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        prefixIcon: Icon(Icons.lock_outlined),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                      ),
                                      onChanged: (data) {
                                        confirmpassword = data;
                                      },
                                    )),
                                const SizedBox(
                                  height: 40,
                                ),
                                (state.status == LoginsignupStatus.signingin)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (name.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Provide Full Name.'),
                                                  ),
                                                );
                                              } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(email)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content:
                                                        Text('Invalid Email'),
                                                  ),
                                                );
                                              } else if (phoneno.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Enter Phone Number.'),
                                                  ),
                                                );
                                              } else if (phoneno.length < 10) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Phone Number Incomplete'),
                                                  ),
                                                );
                                              } else if (phoneno.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        'Enter Phone Number'),
                                                  ),
                                                );
                                              } else if (password !=
                                                  confirmpassword) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 800),
                                                    content: Text(
                                                        "Password mismatch"),
                                                  ),
                                                );
                                              } else {
                                                BlocProvider.of<
                                                            LoginsignupBloc>(
                                                        context)
                                                    .add(Signup(
                                                        name: name,
                                                        email: email,
                                                        phoneno: phoneno,
                                                        password: password,
                                                        deviceToken:
                                                            deviceToken,
                                                        dealPresent: false,
                                                        dealToken: ""));
                                              }
                                            },
                                            child: Image.asset(
                                              'lib/core/assets/images/buttons/signin_button_icon.jpg',
                                              width: 90,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 10, 15, 10),
                                              primary: Palette.kToDark,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: () {
                                  name = "";
                                  email = "";
                                  phoneno = "";
                                  password = "";
                                  confirmpassword = "";
                                  deviceToken = "";
                                  setState(() {
                                    currentPage = pages.login;
                                  });
                                },
                                child: const Text(
                                  " Sign in",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Palette.kToDark),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.status == LoginsignupStatus.authenticated) {
            Navigator.pushNamed(context, '/welcome_screen');
          } else if (state.status == LoginsignupStatus.unauthenticated) {
            if (state.errorstatus == LoginsignupErrorStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 800),
                  content: Text("Login Failed"),
                ),
              );
            }
          }
        },
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
    // Get the registration token FCM
    getToken();
    super.initState();
  }

  //FCM device Token
  void getToken() async {
    deviceToken = (await FirebaseMessaging.instance.getToken())!;
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
