class LoginModel {
  String? message;
  String? token;
  User? user;

  LoginModel({required this.message, required this.token, required this.user});
  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? role;
  String? gender;
  String? phonenumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.role,
    required this.gender,
    required this.phonenumber,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    role = json['role'];
    gender = json['gender'];
    phonenumber = json['phonenumber'];
  }
}
// {
//     "message": "logged in successfully ",
//     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAwMDEsIm5hbWUiOiJtYXJpbyIsImVtYWlsIjoibWFyaW84NS5naXJnZXNAZ21haWwuY29tIiwiaW1hZ2UiOiJ1cmwiLCJyb2xlIjoiYWRtaW4iLCJnZW5kZXIiOiJtYWxlIiwicGhvbmVudW1iZXIiOiIwMTI4NTk0ODAxMSIsImlhdCI6MTc2NTI4NjQyNn0.Ej8W1UIJ9OtJvnJ4UrYR5JGcE_JUWKq0YY_DjXbQSas",
//     "user": {
//         "id": 30001,
//         "name": "mario",
//         "email": "mario85.girges@gmail.com",
//         "image": "url",
//         "role": "admin",
//         "gender": "male",
//         "phonenumber": "01285948011"
//     }
// }    "phonenumber": "01285948011"