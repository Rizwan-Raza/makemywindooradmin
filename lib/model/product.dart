class Product {
  String name;
  String price;
  String description;
  String imageUrl;
  String productId;
  String type;
  DateTime createdOn;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.productId,
    required this.type,
    required this.createdOn,
  });

  factory Product.empty() {
    return Product(
      name: '',
      price: '',
      description: '',
      imageUrl: '',
      productId: '',
      type: '',
      createdOn: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'productId': productId,
      'type': type,
      'createdOn': createdOn.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      productId: map['productId'],
      type: map['type'],
      createdOn: DateTime.parse(map['createdOn']),
    );
  }

  @override
  String toString() {
    return 'Product{name: $name, price: $price, description: $description, imageUrl: $imageUrl, productId: $productId, type: $type, createdOn: $createdOn}';
  }
}
