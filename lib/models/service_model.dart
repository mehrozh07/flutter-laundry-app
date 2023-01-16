class ServiceModel{
  String? name;
  String? image;
  String? productId;

  ServiceModel({this.name, this.image, this.productId});

  factory ServiceModel.fromJson(json)=>ServiceModel(
    name: json['name'],
    image: json['image'],
    productId: json['productId'],
  );
}