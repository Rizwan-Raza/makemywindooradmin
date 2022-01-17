class Product {
  String? pImageURL, pName, pDescription, pType, pPrice, pProductId;

  factory Product.empty() => Product(
      pImageURL: "",
      pName: "",
      pDescription: "",
      pType: "",
      pPrice: "",
      pProductId: "");
  Product(
      {this.pImageURL,
      this.pName,
      this.pDescription,
      this.pType,
      this.pPrice,
      this.pProductId});
  Map<String, dynamic> toJson() {
    return {
      'pImageURL': pImageURL,
      'pName': pName,
      'pDescription': pDescription,
      'pType': pType,
      'pPrice': pPrice,
      'pProductId': pProductId,
    };
  }

  @override
  String toString() {
    return 'Product{pImageURL: $pImageURL, pName: $pName, pDescription: $pDescription, pType:$pType, pPrice: $pPrice,pProductId:$pProductId}';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pImageURL: json['pImageURL'],
      pName: json['pName'],
      pDescription: json['pDescription'],
      pType: json['pType'],
      pPrice: json['pPrice'],
      pProductId: json['pProductId'],
    );
  }
}
