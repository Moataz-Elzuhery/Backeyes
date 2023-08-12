import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/screens/members/cubit/states.dart';
import 'package:BackEyes/services/member_model.dart';
import 'package:BackEyes/services/users.dart';
import 'package:BackEyes/shared/components/component.dart';

import '../../../shared/network/local_network.dart';

class MembersCubit extends Cubit<MembersStates> {
  MembersCubit() : super(MembersInitialState());

  static MembersCubit get(context) => BlocProvider.of(context);

  List<MemberModel> memberList = [];

  void getMembers() async {
    String? token = User.loggedInUser!.apiToken ;
    emit(MembersLoadingState());
    try {
      final response = await http.get(Uri.parse("$localhost/BackEyes_v2/public/api/members"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final responseBody = json.decode(response.body);
      print(responseBody); // Log the response body to the console

      if (response.statusCode == 200) {
        if (responseBody is! List) { // Check if responseBody is not a List
          throw Exception('Failed to load members. Response body is not a List');
        }
        memberList = responseBody.map((member) => MemberModel.fromJson(member)).toList();
        emit(MembersSuccessState(memberList));
      } else {
        throw Exception('Failed to load data.');
      }
    } catch (error) {
      emit(MembersErrorState( 'Failed to load data. $error'));
      print(error);
    }
  }

}


