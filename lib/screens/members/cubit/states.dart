import 'package:BackEyes/services/member_model.dart';

abstract class MembersStates {}

class MembersInitialState extends MembersStates {}

class MembersLoadingState extends MembersStates {}

class MembersSuccessState extends MembersStates {
  final List<MemberModel> memberList;

  MembersSuccessState(this.memberList);
}

class MembersErrorState extends MembersStates {
  final String error;

  MembersErrorState(this.error);
}
