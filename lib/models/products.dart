class Products {
  int id;
  String title;
  double price;
  String category;
  String description;
  String image;

  Products(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.description,
      required this.image});
  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );
}
