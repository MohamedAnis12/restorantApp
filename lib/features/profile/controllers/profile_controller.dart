// في ملف profile_controller.dart

import 'package:craxe/functions/is_dark.dart';
import 'package:craxe/helper/casheHelper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // 💡 متغيرات Rx لتخزين بيانات المستخدم وعرضها في الواجهة
  var userName = 'Guest User'.obs;
  var userEmail = 'user@example.com'.obs;
  var userImage = ''.obs; // رابط الصورة

  // مفاتيح الـ Cache
  static const USER_NAME_KEY = 'userName';
  static const USER_EMAIL_KEY = 'userEmail';
  static const USER_IMAGE_KEY = 'userImage';
  // يمكنك إضافة المزيد مثل 'userPhone' و 'userGender'

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  // دالة لتحميل البيانات من الذاكرة المحلية
  void loadUserProfile() {
    // 💡 قراءة الاسم والإيميل من CasheHelper
    final name = CasheHelper().getData(key: USER_NAME_KEY) as String?;
    final email = CasheHelper().getData(key: USER_EMAIL_KEY) as String?;
    final image = CasheHelper().getData(key: USER_IMAGE_KEY) as String?;

    if (name != null) {
      userName.value = name;
    }
    if (email != null) {
      userEmail.value = email;
    }
    if (image != null) {
      userImage.value = image;
    }
  }

  final fullName = ''.obs;
  final lightTheme = (!isDark()).obs;
}
