class MemberModel {
  final String memberName;
  final String memberImage;

  MemberModel({required this.memberName, required this.memberImage});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberName: json['member_name'] as String,
      memberImage: json['member_image'] as String,
    );
  }
}
