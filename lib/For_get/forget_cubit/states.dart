
abstract class ForgetStates{}
class ForgetInitialState extends ForgetStates{}

class ForgetLoadingState extends ForgetStates{}
class ForgetSuccessState extends ForgetStates{}
class FailedToForgetState extends ForgetStates{
  String message;
  FailedToForgetState({required this.message});
}

class SendCodeLoadingState extends ForgetStates{}
class SendCodeSuccessState extends ForgetStates{}
class SendCodeFailedState extends ForgetStates{
  String message;
  SendCodeFailedState({required this.message});
}
class ChangePasswordLoadingState extends ForgetStates{}
class ChangePasswordSuccessState extends ForgetStates{}
class ChangePasswordFailedState extends ForgetStates{
  String message;
  ChangePasswordFailedState({required this.message});
}

class ResendCodeState extends ForgetStates{

}