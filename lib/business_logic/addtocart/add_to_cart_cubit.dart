import 'package:craxe/business_logic/addtocart/add_to_cart_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddToCartStates> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addItemToCart({
    required int mealId,
    required int quantity,
  }) async {
    if (isClosed) return;
    emit(AddToCartLoading());

    final String? userIdString = CasheHelper().getData(key: 'userId') as String?;
    final int? userId = int.tryParse(userIdString ?? '');

    if (userId == null) {
      if (!isClosed) emit(AddToCartError(errorMessage: 'User ID is missing or invalid.'));
      return;
    }

    try {
      final response = await DioHelper.postData(
        url: 'cart/add', // 💡 المسار الصحيح
        data: {
          'userid': userId,
          'mealid': mealId,
          'quantity': quantity,
        },
      );

      // تحليل الرد (يفترض أن الرد سيكون JSON بسيط)
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!isClosed) emit(AddToCartSuccess());
      } else {
        if (!isClosed) emit(AddToCartError(errorMessage: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? e.message ?? 'Server error occurred.';
      if (!isClosed) emit(AddToCartError(errorMessage: message));
    } catch (e) {
      if (!isClosed) emit(AddToCartError(errorMessage: 'An unexpected error: ${e.toString()}'));
    }
  }
}
