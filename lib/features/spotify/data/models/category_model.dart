import '../../domain/domain.dart' show Category;

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.href,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? 'Unknown',
      imageUrl: map['icons'][0]['url'] as String? ?? '',
      href: map['href'] as String? ?? '',
    );
  }
}
