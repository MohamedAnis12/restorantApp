class Registermodel {
  String? message;

  Registermodel({required this.message});
  factory Registermodel.fromJson(Map<String, dynamic> json) {
    return Registermodel(message: json['message'] as String);
  }
}
