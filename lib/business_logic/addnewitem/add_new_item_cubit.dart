import 'package:craxe/business_logic/addnewitem/add_new_item_states.dart';
import 'package:craxe/core/networking/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    required String image,
    required String category,
  }) async {
    if (!isClosed) {
      emit(AddProductLoadingState());
    }

    try {
      final response = await DioHelper.postData(
        url: 'meals/new-meal', // ⚠️ هذا هو المسار الافتراضي، يجب تأكيده
        data: {
          "name": name,
          "description": description,
          "price": price,
          "image": image,
          "category": category,
        },
      );

      // 💡 تحليل الرد الناجح: قد يحتوي فقط على رسالة نجاح
      String successMessage =
          response.data['message'] ?? 'Item added successfully!';

      if (!isClosed) {
        emit(AddProductSuccessState(message: successMessage));
      }
    } on DioException catch (e) {
      String errorMessage;
      final responseData = e.response?.data;

      // معالجة آمنة لرسالة الخطأ
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'] as String;
      } else {
        errorMessage = e.message ?? 'Failed to add item due to a server error.';
      }

      print(e.toString());

      if (!isClosed) {
        emit(AddProductErrorState(errorMessage: errorMessage));
      }
    } catch (e) {
      print(e.toString());

      if (!isClosed) {
        emit(AddProductErrorState(errorMessage: e.toString()));
      }
    }
  }
}
