
import 'package:craxe/data/models/MealsResponseModel.dart';
abstract class HomeStates {}
class HomeInitialState extends HomeStates {}
class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final MealsResponseModel mealsResponseModel;

  HomeSuccessState({required this.mealsResponseModel});
}

class HomeErrorState extends HomeStates {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}