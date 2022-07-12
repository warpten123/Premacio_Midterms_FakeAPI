class Product {
  dynamic productId;
  int price;
  String title;
  String description;

  Product(
      {this.productId,
      required this.price,
      required this.title,
      required this.description});
}
