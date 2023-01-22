class ServiceModel{
  String? name;
  String? image;
  String? productId;
  String? serviceType;
  int? price;

  ServiceModel({this.name, this.image, this.productId, this.serviceType, this.price});

  factory ServiceModel.fromJson(json)=>ServiceModel(
    name: json['name'],
    image: json['image'],
    productId: json['productId'],
    serviceType: json['serviceType'],
    price: json['price'],
  );
}