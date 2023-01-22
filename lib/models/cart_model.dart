class CartModel{
  final String? cartId;
  final String? cartName;
  final String? cartImage;
  final int? cartPrice;
  final String? genderType;
  int? cartQuantity;
  final bool? idAdd;
  final String? serviceType;


  CartModel({
    this.cartName,
    this.cartImage,
    this.cartId,
    this.cartPrice,
    this.cartQuantity,
    this.genderType,
    this.serviceType,
    this.idAdd,
  });

  factory CartModel.fromJson(json)=> CartModel(
    cartId: json["itemId"],
    cartName: json["serviceName"],
    cartPrice: json["itemPrice"],
    cartImage: json["itemImage"],
    cartQuantity: json["itemQuantity"],
    genderType: json["itemSize"],
    idAdd: json["isAdd"],
    serviceType: json['serviceType'],
  );
  Map<String, dynamic> toJson() =>{
    'itemId': cartId,
    'serviceName': cartName,
    'itemPrice': cartPrice,
    'itemImage': cartImage,
    'itemQuantity': cartQuantity,
    'genderType' : genderType,
    "serviceType": serviceType,
    "isAdd": true,
  };
}