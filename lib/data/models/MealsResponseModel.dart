import 'package:craxe/data/models/MealModel.dart';

class MealsResponseModel {
  final String? message;
  final List<MealModel>? meals;

  MealsResponseModel({this.message, this.meals});

  factory MealsResponseModel.fromJson(Map<String, dynamic> json) {
    return MealsResponseModel(
      message: json['message'] as String?,
      // 💡 تحويل قائمة الـ JSON إلى قائمة من MealModel
      meals: json['meals'] != null
          ? List<MealModel>.from(
              json['meals'].map((x) => MealModel.fromJson(x)),
            )
          : null,
    );
  }
}