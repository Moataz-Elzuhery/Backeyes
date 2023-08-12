import 'package:BackEyes/login/login.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
 final String token;

  LoginSuccessState(this.token);
}
class FailedToLoginState extends LoginStates{
 final String  message;
FailedToLoginState({required this.message,});
}
class ChangeCheckBoxLoginState extends LoginStates{}