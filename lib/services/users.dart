class UserData {
  bool? status;
  String? errorNumber;
  String? message;
  User? user;

  UserData({this.status, this.errorNumber, this.message, this.user});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json['status'] as bool?,
    errorNumber: json['errorNumber'] as String?,
    message: json['message'] as String?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

// Model class representing a user
class User {
  int? id;
  String? name;
  String? email;
  int? verified;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? apiToken;

  User({
    this.id,
    this.name,
    this.email,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.apiToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    verified: json['verified'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    apiToken: json['api_token'] as String?,
  );
  static User? loggedInUser; // Static property to store the logged-in user

  static void updateUser(String token, String name, String email) {
    loggedInUser = User(
      // Create a new User object with updated values
      id: loggedInUser?.id,
      name: name,
      email: email,
      verified: loggedInUser?.verified,
      createdAt: loggedInUser?.createdAt,
      updatedAt: loggedInUser?.updatedAt,
      apiToken: token,
    );
  }

}