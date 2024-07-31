class BrandCardModel {
  final String image;
  final String brandName;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final bool showBorder;
  final bool isVerified;
  final int productCount;

  BrandCardModel({
    required this.productCount,
    required this.image,
    required this.brandName,
    this.onTap,
    this.height,
    this.width,
    this.showBorder = false,
    this.isVerified = false,
  });
}
