class MealModel {
  final int? id;
  final String? name;
  final String? description;
  final double? price; // نستخدم double لأن السعر قد يكون عشرياً (6.5)
  final String? image;
  final String? category;
  
  MealModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    // 💡 ملاحظة: يجب تحويل الـ Price إلى double إذا كان في الـ JSON int أو num
    final priceValue = json['price'];
    
    return MealModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      
      // تحويل رقمي آمن: يفضل استخدام toDouble() أو التأكد من النوع
      price: priceValue != null ? double.tryParse(priceValue.toString()) : null,
      
      image: json['image'] as String?,
      category: json['category'] as String?,
    );
  }
}