import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/shared/components/component.dart';

import 'states.dart';

class ForgetCubit extends Cubit<ForgetStates> {
  ForgetCubit() : super(ForgetInitialState());

  Future<void> forget({required String email}) async {
    emit(ForgetLoadingState());

    try {
      Response response = await http.post(
        Uri.parse("$localhost/BackEyes_v2/public/api/forget-password"),
        body: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("User login success and his Data is: $data");
          emit(ForgetSuccessState());
        } else {
          debugPrint("Failed to login, reason is: ${data['message']}");
          emit(FailedToForgetState(message: data['message']));
        }
      }
    } catch (e) {
      emit(FailedToForgetState(message: e.toString()));
    }
  }

  static ForgetCubit get(BuildContext context) =>
      BlocProvider.of<ForgetCubit>(context);

  int? userId;
  String? token;

  Future<void> sendCode({required String email, required String code}) async {
    emit(SendCodeLoadingState());

    try {
      Response response = await http.post(
        Uri.parse(
            "$localhost/BackEyes_v2/public/api/verify-code-reset-password"),
        body: {
          "email": email,
          "code": code,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Send Code success and his Data is: $data");
          userId = data['data']['user_id'];
          token = data['data']['token'];
          emit(SendCodeSuccessState());
        } else {
          debugPrint("Failed to send code, reason is: ${data['message']}");
          emit(SendCodeFailedState(message: data['message']));
        }
      }
    } catch (e) {
      emit(SendCodeFailedState(message: e.toString()));
    }
  }

  Future<void> changePassword({required String password}) async {
    emit(ChangePasswordLoadingState());

    try {
      Response response = await http.post(
        Uri.parse("$localhost/BackEyes_v2/public/api/reset-password"),
        body: {
          "user_id": userId,
          "token": token,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          debugPrint("Change password success. Data: $data");
          emit(ChangePasswordSuccessState());

        } else {
          debugPrint("Failed to change password. Reason: ${data['message']}");
          emit(ChangePasswordFailedState(message: data['message']));
        }
      }
    } catch (e) {
      emit(ChangePasswordFailedState(message: e.toString()));
    }
  }

  int seconds = 0;
  bool isTimerRunning = false;
  Timer? timer;

  void startTimer() {
    seconds = 60;
    isTimerRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        stopTimer();
      } else {
        seconds--;
      }
      emit(ResendCodeState());
    });
  }

  void stopTimer() {
    timer?.cancel();
    isTimerRunning = false;
  }


}
