import 'package:flutter/material.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  // 1. تعريف مفتاح الـ Form للتحقق من المدخلات
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. تعريف الـ Controllers لاستقبال النصوص
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  // تنظيف الذاكرة عند إغلاق الصفحة
  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  // دالة الإرسال (تجمع البيانات وترسلها)
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // تجميع البيانات في Map كما هو مطلوب في الـ Backend
      final Map<String, dynamic> productData = {
        "name": _nameController.text,
        "description": _descController.text,
        "price": double.tryParse(_priceController.text) ?? 0.0, // تحويل الرقم
        "image": _imageController.text,
        "category": _categoryController.text,
      };

      // هنا يمكنك استدعاء دالة الـ API الخاصة بك
      print("Data ready to send: $productData");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data... check console')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- حقل الاسم ---
              _buildTextField(
                controller: _nameController,
                label: "Name",
                hint: "ex: Pasta",
                icon: Icons.fastfood,
              ),
              const SizedBox(height: 16),

              // --- حقل الوصف ---
              _buildTextField(
                controller: _descController,
                label: "Description",
                hint: "ex: Pasta with red sauce",
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // --- حقل السعر ---
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

              // --- حقل رابط الصورة ---
              _buildTextField(
                controller: _imageController,
                label: "Image URL",
                hint: "http://example.com/image.png",
                icon: Icons.image,
              ),
              const SizedBox(height: 16),

              // --- حقل التصنيف ---
              _buildTextField(
                controller: _categoryController,
                label: "Category",
                hint: "ex: Italian",
                icon: Icons.category,
              ),
              const SizedBox(height: 32),

              // --- زر الإرسال ---
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color(0xff5941ad),
                ),
                child: const Text(
                  "Submit Item",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
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
