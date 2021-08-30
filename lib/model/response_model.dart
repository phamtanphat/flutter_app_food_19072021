class ResponseModel<T> {
  T? data;
  int? code;
  String? message;

  ResponseModel({this.data, this.code, this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json , Function fromJsonModel) {
    final value = json['data'].cast<Map<String, dynamic>>();
    return ResponseModel<T>(
      code: json['code'],
      message: json['message'],
      data: fromJsonModel(value)
    );
  }
}
