class ProductPriceTextModel {
  final String price;
  final bool lineThrough;
  final bool smallSize;
  final String currencySymbol;
  final int maxLines;

  ProductPriceTextModel({
    required this.price,
    this.lineThrough = false,
    this.smallSize = false,
    this.currencySymbol = "\$",
    this.maxLines = 1,
  });
}
