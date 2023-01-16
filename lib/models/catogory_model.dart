class CategoryModel {
  String? service;
  String? serviceImage;
  String? serviceId;

  CategoryModel({
    this.service,
    this.serviceImage,
    this.serviceId,
  });

  factory CategoryModel.fromJson(json) => CategoryModel(
        service: json['service'],
        serviceImage: json['imageUrl'],
        serviceId: json['serviceId'],
      );
}