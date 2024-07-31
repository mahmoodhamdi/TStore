class ProductViewModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String brand;
  final String rating;
  final String? stock;
  final String? discount;
  ProductViewModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.rating,
    required this.stock,
    required this.discount,
  });
}
