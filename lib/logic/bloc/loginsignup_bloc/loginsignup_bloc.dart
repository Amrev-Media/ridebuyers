import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:riderbuyers/core/constants/strings.dart';
import 'package:riderbuyers/data/dataproviders/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:riderbuyers/data/repositories/riderbuyersapi/riderbuyersapi.dart';

part 'loginsignup_bloc_event.dart';
part 'loginsignup_bloc_state.dart';

class LoginsignupBloc
    extends HydratedBloc<LoginsignupBlocEvent, LoginsignupBlocState> {
  LoginsignupBloc() : super(const LoginsignupBlocState()) {
    on<LoginsignupBlocEvent>(_loginsignupEventHandler,
        transformer: droppable());
    print(state);
  }

  Future<void> _loginsignupEventHandler(
      LoginsignupBlocEvent event, Emitter<LoginsignupBlocState> emit) async {
    //Login EVENT
    if (event is Login) {
      emit(state.copyWith(status: LoginsignupStatus.loggingin));
      if (state.status != LoginsignupStatus.authenticated) {
        Map<String, dynamic> response =
            await RiderbuyersAPI_LoginSignup.login(event.phoneno, event.password, event.deviceToken);
        try {
          print(response);
          if (response['success'] == true) {
            if(response.containsKey('dealToken')){
              emit(state.copyWith(
                  status: LoginsignupStatus.authenticated,
                  name: response['name'],
                  phone: response['phone'],
                  password: event.password,
                  email: response['email'],
                  errorstatus: LoginsignupErrorStatus.success,
                  dealPresent: true,
                  dealToken: response['dealToken'],
                  make: response['make'],
                  model: response['model'],
                  year: response['year'].toString(),
                  kilometres: response['kilometres'].toString(),
                  vin: ""
              ));
            }else {
              emit(state.copyWith(
                status: LoginsignupStatus.authenticated,
                name: response['name'],
                phone: response['phone'],
                password: event.password,
                email: response['email'],
                errorstatus: LoginsignupErrorStatus.success,
                dealPresent: false,
                dealToken: "",
                make: "",
                model: "",
                year: "",
                kilometres: "",
                vin: ""
              ));
            }
          }
          else{
            emit(state.copyWith(
              status: LoginsignupStatus.unauthenticated,
              errorstatus: LoginsignupErrorStatus.error,
            ));
          }
        } catch (_) {
          print("Error in Logging part of LoginsingupBloc $_");
          emit(state.copyWith(
            status: LoginsignupStatus.unauthenticated,
            errorstatus: LoginsignupErrorStatus.error,
          ));
        }
      }
    }

    //Signup EVENT
    if (event is Signup) {
      if (state.status != LoginsignupStatus.authenticated) {
        emit(state.copyWith(status: LoginsignupStatus.signingin));
        dynamic response = await RiderbuyersAPI_LoginSignup.signup(event.name,
            event.phoneno, event.email, event.password, event.deviceToken);
        print(response);
        if (response['success'] == true) {
          emit(state.copyWith(
              status: LoginsignupStatus.authenticated,
              errorstatus: LoginsignupErrorStatus.success,
              name: event.name,
              phone: event.phoneno,
              password: event.password,
              email: event.email));
        } else {
          emit(state.copyWith(
            status: LoginsignupStatus.unauthenticated,
            errorstatus: LoginsignupErrorStatus.error,
          ));
        }
      }
    }

    //LOGOUT EVENT
    else if (event is Logout) {
      emit(state.copyWith(
        status: LoginsignupStatus.unauthenticated,
        errorstatus: LoginsignupErrorStatus.initial,
        name: "",
        phone: "",
        password: "",
        email: "",
        dealPresent: false,
        dealToken: "",
        make: "",
        model: "",
        year: "",
        kilometres: "",
        vin: ""
      ));
      await _logout();
    }
  }

  @override
  LoginsignupBlocState fromJson(Map<String, dynamic> json) {
    return LoginsignupBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(LoginsignupBlocState state) {
    return state.toMap();
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _loginAction() async {}

  Future<void> _logout() async {}
}
