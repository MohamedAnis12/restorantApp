import 'package:craxe/business_logic/home/home_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/MealsResponseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart'; // نحتاجها للتعامل مع DioException

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  Future<void> getMeals() async {
    if (!isClosed) { // 💡 تحقق: تأمين emit(Loading)
      emit(HomeLoadingState());
    }

    try {
      // ⚠️ ملاحظة: لا يزال مسار 'meals/all-meals' يُرجِع خطأ 404. تأكد من تعديله.
      final response = await DioHelper.getData(
        url: 'meals/get-all-meals', // افترضنا هذا المسار
      );

      // 💡 تحليل الرد الناجح
      MealsResponseModel mealsData = MealsResponseModel.fromJson(response.data);

      if (!isClosed) { // 💡 تحقق: تأمين emit(Success)
        emit(HomeSuccessState(mealsResponseModel: mealsData));
      }

    } on DioException catch (e) {
      String errorMessage;
      final responseData = e.response?.data;

      // الحل: التحقق الآمن مما إذا كان الرد هو Map ويحتوي على مفتاح 'message'
      if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else {
        errorMessage = e.message ?? 'Failed to fetch meals due to unknown error.';
      }

      if (!isClosed) { // 💡 تحقق: تأمين emit(Error)
        emit(HomeErrorState(errorMessage: errorMessage));
      }
      
      // طباعة الرد الخطأ للمساعدة في Debugging
      print('--- MEALS FETCH ERROR ---');
      print('Status: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('-------------------------');

    } catch (e) {
      // معالجة أخطاء التحليل (Parsing) غير المتوقعة
      if (!isClosed) { // 💡 تحقق: تأمين emit(Unexpected Error)
        emit(HomeErrorState(errorMessage: 'An unexpected error occurred: ${e.toString()}'));
      }
    }
  }
}