// في ملف cart_cubit.dart

import 'package:craxe/business_logic/cart/cart_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:craxe/data/models/CartResponseModel.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  Future<void> fetchCart() async {
    if (isClosed) return;
    emit(CartLoadingState());

    try {
      // ⚠️ المسار الافتراضي لجلب السلة. قد يحتاج للتأكيد أو التعديل.
      final response = await DioHelper.getData(url: 'cart/');

      // 💡 تحليل الرد الناجح إلى CartResponseModel
      CartResponseModel cartResponse = CartResponseModel.fromJson(
        response.data,
      );

      if (!isClosed) {
        emit(CartSuccessState(cartResponse: cartResponse));
      }
    } on DioException catch (e) {
      String errorMessage;
      final responseData = e.response?.data;

      // معالجة آمنة لرسالة الخطأ
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else {
        errorMessage = e.message ?? 'Failed to fetch cart due to server error.';
      }

      if (!isClosed) {
        emit(CartErrorState(errorMessage: errorMessage));
      }

      print('--- CART FETCH ERROR ---');
      print('Status: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('------------------------');
    } catch (e) {
      if (!isClosed) {
        emit(
          CartErrorState(
            errorMessage: 'An unexpected error occurred: ${e.toString()}',
          ),
        );
        print(e.toString());
      }
    }
  }

  // في ملف cart_cubit.dart، داخل دالة removeItem

  // في ملف cart_cubit.dart

  Future<void> removeItem({
    required int cartItemId,
    required int mealId,
  }) async {
    // 💡 تم إضافة mealId
    if (isClosed) return;
    emit(CartLoadingState());

    // 💡 1. جلب userId من الـ Cache
    final String? userIdString =
        CasheHelper().getData(key: 'userId') as String?;
    final int? userId = int.tryParse(userIdString ?? '');

    if (userId == null) {
      if (!isClosed)
        emit(CartErrorState(errorMessage: 'User ID is missing from cache.'));
      return;
    }

    try {
      // 💡 2. إرسال البيانات الثلاثة المطلوبة
      final response = await DioHelper.deleteData(
        url: 'cart/item',
        data: {
          'cart_item_id': cartItemId,
          'userid': userId, // 💡 إضافة userid
          'mealid': mealId, // 💡 إضافة mealid
        },
      );

      // 💡 في حال النجاح (Status 200)
      if (response.statusCode == 200) {
        // طباعة رسالة نجاح للمستخدم (اختياري)
        print('Item ${cartItemId} removed successfully.');
        await fetchCart(); // إعادة جلب السلة لتحديث الواجهة
      } else {
        // إذا كان هناك Status Code غير متوقع ولكن ليس DioException
        if (!isClosed)
          emit(
            CartErrorState(
              errorMessage:
                  'Failed to delete item. Status: ${response.statusCode}',
            ),
          );
      }
    } on DioException catch (e) {
      String errorMessage;
      final responseData = e.response?.data;

      // 💡 معالجة آمنة لرسالة الخطأ
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else if (responseData is String) {
        // إذا كان الرد مجرد نص خام (مثل رسالة 404 HTML)
        errorMessage = responseData;
      } else {
        // استخدام رسالة خطأ Dio الافتراضية
        errorMessage = e.message ?? 'Server error during deletion.';
      }

      if (!isClosed) emit(CartErrorState(errorMessage: errorMessage));

      print('--- REMOVE ITEM ERROR ---');
      print('Status: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');
      print('---------------------------');
    } catch (e) {
      // معالجة أخطاء التحليل الأخرى
      if (!isClosed)
        emit(
          CartErrorState(errorMessage: 'An unexpected error: ${e.toString()}'),
        );
      print(e.toString());
    }
  } // 💡 تم إضافة القوس الناقص هنا

  // ... (بقية الكلاس)
}
