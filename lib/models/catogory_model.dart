class CategoryModel {
  String? serviceName;
  String? serviceImage;
  String? serviceId;
  List<dynamic>? services;

  CategoryModel({
    this.serviceName,
    this.serviceImage,
    this.serviceId,
    this.services,
  });

  factory CategoryModel.fromJson(json) => CategoryModel(
        serviceName: json['service'],
        serviceImage: json['imageUrl'],
        serviceId: json['serviceId'],
        services: json['services']
      );
}