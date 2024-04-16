class CartModel {
  final String productName;
  final int productPrice;
  final String brandName;
  final List imageUrl;
  final String storeId;
  int quantity;
  final String productId;
  final String productSize;
  final int discount;
  final String description;

  CartModel(
      {required this.productName,
      required this.productPrice,
      required this.brandName,
      required this.imageUrl,
      required this.quantity,
      required this.productId,
      required this.productSize,
      required this.discount,
      required this.description, required this.storeId});
}