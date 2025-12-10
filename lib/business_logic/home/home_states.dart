
abstract class HomeStates {}
class HomeInitialState extends HomeStates {}
class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {

  HomeSuccessState();
}

class HomeErrorState extends HomeStates {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}