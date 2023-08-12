import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/shared/components/component.dart';
import 'dart:convert';

import '../../services/users.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserData? model;
  bool val = false;

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final url = Uri.parse('$localhost/BackEyes_v2/public/api/login');
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        model = UserData.fromJson(data);
        print(data);

        if (model?.status == true) {
          final user = model?.user;
          if (user != null) {
            // Update the User.loggedInUser object with token and name
            User.updateUser(user.apiToken!, user.name!,user.email!);
          }

          emit(LoginSuccessState(model!.user!.apiToken!));
          print(model?.message);
          print(model?.status);
        } else {
          // Handle login error (e.g., display an error message)
          emit(FailedToLoginState(message: model?.message ?? 'Login failed'));
        }
      } else {
        // Handle HTTP error (e.g., display an error message)
        emit(FailedToLoginState(message: 'HTTP error: ${response.statusCode}'));
      }
    } catch (e) {
      // Handle network or exception error (e.g., display an error message)
      emit(FailedToLoginState(message: e.toString()));
    }
  }


  void changebox(bool val1) {
    val = val1;
    print(val);
    emit(ChangeCheckBoxLoginState());
  }
}
