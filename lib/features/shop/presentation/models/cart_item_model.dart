class CartItemModel {
  final String itemName;
  final String color;
  final String size;
  final String brand;
  final String image;
  final double quantity;
  final String total;
  
  CartItemModel({
    required this.itemName,
    required this.color,
    required this.size,
    required this.brand,
    required this.image,
     this.quantity=0,
    required this.total,
  });}
