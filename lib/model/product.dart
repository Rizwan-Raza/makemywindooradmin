class Product {
  String pName;
  String pPrice;
  String pDescription;
  String pImageURL;
  String pProductId;
  String pType;

  Product({
    required this.pName,
    required this.pPrice,
    required this.pDescription,
    required this.pImageURL,
    required this.pProductId,
    required this.pType,
  });

  factory Product.empty() {
    return Product(
      pName: '',
      pPrice: '',
      pDescription: '',
      pImageURL: '',
      pProductId: '',
      pType: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pName': pName,
      'pPrice': pPrice,
      'pDescription': pDescription,
      'pImageURL': pImageURL,
      'pProductId': pProductId,
      'pType': pType,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pName: map['pName'],
      pPrice: map['pPrice'],
      pDescription: map['pDescription'],
      pImageURL: map['pImageURL'],
      pProductId: map['pProductId'],
      pType: map['pType'],
    );
  }

  @override
  String toString() {
    return 'Product{pName: $pName, pPrice: $pPrice, pDescription: $pDescription, pImageURL: $pImageURL, pProductId: $pProductId, pType: $pType}';
  }
}
