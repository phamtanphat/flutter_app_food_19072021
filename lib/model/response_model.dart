
class ResponseModel<T> {
  T? data;
  int? code;
  String? message;

  ResponseModel({this.data, this.code, this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json , Function fromJsonModel) {
    return ResponseModel(
      code: json['code'],
      message: json['message'],
      data: fromJsonModel(json['data'])
    );
  }
}
