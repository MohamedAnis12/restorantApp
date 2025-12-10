import 'dart:developer';

import 'package:craxe/business_logic/home/home_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/MealsResponseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart'; // نحتاجها للتعامل مع DioException

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  Future<void> getMeals() async {
    log('tttttttttttttttttttttttttttttttttttttt');
    if (!isClosed) {
      // 💡 تحقق: تأمين emit(Loading)
      emit(HomeLoadingState());
    }
    if (!isClosed) {
      try {
        final response = await DioHelper.getData(
          url: 'meals/get-all-meals', // افترضنا هذا المسار
        );
        log("get Mealllllllllllllllll");
        MealsResponseModel mealsData = MealsResponseModel.fromJson(
          response.data,
        );

        emit(HomeSuccessState(mealsResponseModel: mealsData));
        print('DEBUG: HomeSuccessState EMITTED successfully.');
      } on DioException catch (e) {
        String errorMessage;
        final responseData = e.response?.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('message')) {
          errorMessage = responseData['message'] as String;
        } else {
          errorMessage =
              e.message ?? 'Failed to fetch meals due to unknown error.';
        }

        if (!isClosed) {
          // 💡 تحقق: تأمين emit(Error)
          emit(HomeErrorState(errorMessage: errorMessage));
        }

        // طباعة الرد الخطأ للمساعدة في Debugging
        print('--- MEALS FETCH ERROR ---');
        print('Status: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('-------------------------');
      } catch (e) {
        // معالجة أخطاء التحليل (Parsing) غير المتوقعة
        if (!isClosed) {
          // 💡 تحقق: تأمين emit(Unexpected Error)
          emit(
            HomeErrorState(
              errorMessage: 'An unexpected error occurred: ${e.toString()}',
            ),
          );
        }
      }
    }
  }
}
