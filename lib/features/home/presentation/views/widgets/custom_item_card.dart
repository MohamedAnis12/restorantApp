import 'package:craxe/data/models/MealModel.dart';
import 'package:craxe/features/addNewItemToCart/presentation/views/add_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItemCard extends StatelessWidget {
  final MealModel meal;

  const CustomItemCard({
    super.key,
    required this.meal, // يجب تمرير الوجبة من CustomGrid
  });

  @override
  Widget build(BuildContext context) {
    // 💡 الحصول على القيمة الافتراضية للصور في حال عدم وجود صورة
    final imageUrl = meal.image?.isNotEmpty == true
        ? meal.image!
        : "assets/images/placeholder.png"; // استبدل بمسار صورة افتراضية لديك

    return InkWell(
      // 💡 تغليفها بـ InkWell لجعل البطاقة كلها قابلة للنقر
      onTap: () {
        // يمكنك توجيه المستخدم لصفحة تفاصيل الوجبة أو إضافة العربة
        Get.to(() => AddItemView(meal: meal), transition: Transition.fadeIn);
      },
      child: Container(
        height: 200,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xffece9eb).withOpacity(.3),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 💡 2. استخدام صورة الوجبة الفعلية (Image URL)
            Container(
              height: 125,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  // 💡 استخدام NetworkImage للصورة القادمة من API
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover, // لتغطية مساحة الصورة
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      // 💡 3. عرض اسم الوجبة
                      Expanded(
                        child: Text(
                          meal.name ?? "لا يوجد اسم",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 💡 4. عرض سعر الوجبة
                      Text(
                        // التحقق من القيمة وعرضها مع عملة (مثل $)
                        r'$'
                        '${meal.price?.toStringAsFixed(2) ?? "0.00"}',
                        style: const TextStyle(
                          color: Color(0xffa7a04d),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // زر الإضافة (Add to Cart)
                      InkWell(
                        onTap: () {
                          // يمكنك تمرير الـ meal object هنا لصفحة AddItemView
                          Get.to(
                            () => AddItemView(meal: meal),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: const Icon(
                          Icons.add_circle,
                          color: Color(0xff0f7a44),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
