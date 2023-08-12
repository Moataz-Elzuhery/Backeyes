abstract class AuthStates{}
class AuthInitialState extends AuthStates{}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{
  final String token;

  RegisterSuccessState(this.token);
}
class FailedToRegisterState extends AuthStates{
  String message;
  FailedToRegisterState({required this.message});
}

class ChangeCheckBoxRegisterState extends AuthStates{}
