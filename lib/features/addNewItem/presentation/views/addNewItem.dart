import 'package:craxe/business_logic/addnewitem/add_new_item_cubit.dart';
import 'package:craxe/business_logic/addnewitem/add_new_item_states.dart';
import 'package:craxe/business_logic/home/Home_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: const _AddProductViewBody(), // استخدام كلاس فرعي لجسم الشاشة
    );
  }
}

// الكلاس الأصلي أصبح الكلاس الفرعي (للتأكد من أن BlocConsumer لديه BuildContext صحيح)
class _AddProductViewBody extends StatefulWidget {
  const _AddProductViewBody();

  @override
  State<_AddProductViewBody> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<_AddProductViewBody> {
  // 1. تعريف مفتاح الـ Form للتحقق من المدخلات
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. تعريف الـ Controllers لاستقبال النصوص
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  // تنظيف الذاكرة عند إغلاق الصفحة
  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  // 💡 دالة الإرسال: تستدعي Cubit لإرسال البيانات
  Future<void> _submitForm(String? catagory) async {
    final cubit = context.read<AddProductCubit>(); // قراءة الكيوبت

    if (_formKey.currentState!.validate()) {
      if (catagory != null) {
        await cubit.addProduct(
          name: _nameController.text,
          description: _descController.text,
          price: double.tryParse(_priceController.text) ?? 0.0,
          image: _imageController.text,
          category: catagory,
        );
        final homeCubit = context.read<HomeCubit>();

        // استدعاء دالة جلب الوجبات لتحديث شاشة Home
        await homeCubit.getMeals();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('catagory is required')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 💡 2. إضافة BlocConsumer لمعالجة الحالات وعرض رسائل التنبيه
    return BlocConsumer<AddProductCubit, AddProductStates>(
      listener: (context, state) async {
        if (state is AddProductSuccessState) {
          // قراءة HomeCubit

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Success: ${state.message}')));

          // العودة للشاشة السابقة (شاشة Home)
          Get.back();
          // Get.back(); // العودة للشاشة السابقة بعد النجاح
        } else if (state is AddProductErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        String? catagory;

        return Scaffold(
          appBar: AppBar(title: const Text("Add New Item")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // --- حقول الإدخال (بدون تغيير) ---
                  _buildTextField(
                    controller: _nameController,
                    label: "Name",
                    hint: "ex: Pasta",
                    icon: Icons.fastfood,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descController,
                    label: "Description",
                    hint: "ex: Pasta with red sauce",
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _priceController,
                    label: "Price",
                    hint: "ex: 6.5",
                    icon: Icons.attach_money,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    isNumber: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _imageController,
                    label: "Image URL",
                    hint: "http://example.com/image.png",
                    icon: Icons.image,
                  ),
                  const SizedBox(height: 16),
                  DropdownMenu(
                    width: double.infinity,
                    hintText: 'Catagory',
                    onSelected: (value) {
                      catagory = value!;
                    },
                    dropdownMenuEntries: [
                      DropdownMenuEntry<String>(
                        label: 'Burger',
                        value: 'Burger',
                      ),
                      DropdownMenuEntry<String>(label: 'Pizza', value: 'Pizza'),
                      DropdownMenuEntry<String>(
                        label: 'Dessert',
                        value: 'Dessert',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // --- زر الإرسال ---
                  ElevatedButton(
                    // 💡 تعطيل الزر أثناء التحميل لمنع الإرسال المزدوج
                    onPressed: state is AddProductLoadingState
                        ? null
                        : () => _submitForm(catagory),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xff5941ad),
                    ),
                    child: state is AddProductLoadingState
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Submit Item",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget مساعد لتقليل تكرار الكود
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
