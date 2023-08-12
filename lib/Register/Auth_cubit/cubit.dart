import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/Register/Auth_cubit/states.dart';
import 'package:BackEyes/shared/components/component.dart';

import '../../services/users.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  bool val = false;
  UserData? model;

  // Register user
  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    try {
      // Make an HTTP POST request to the register endpoint
      Response response = await http.post(
        Uri.parse("$localhost/BackEyes_v2/public/api/register"),
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      // Decode the response body
      var responseBody = jsonDecode(response.body);

      // Create a UserData instance from the decoded response body
      model = UserData.fromJson(responseBody);

      print(responseBody);

      // Emit a RegisterSuccessState with the user's API token
      emit(RegisterSuccessState(model!.user!.apiToken!));
    } catch (e) {
      print('===================================================');
      print(e.toString());

      // Emit a FailedToRegisterState with the error message
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  // Change the value of the checkbox
  void changeBox(bool val1) {
    val = val1;
    print(val);

    // Emit a ChangeCheckBoxRegisterState
    emit(ChangeCheckBoxRegisterState());
  }
}
