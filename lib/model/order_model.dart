class OrderModel {
  String? orderId;
  int? total;

  OrderModel({required this.orderId,required this.total});

  OrderModel.fromJson(Map<String, dynamic> json) {
    this.orderId = json['orderId'];
    this.total = json['total'];
  }


}