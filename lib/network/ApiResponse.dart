class ApiResponse {
  bool status;
  int statusCode;
  String msg;
  dynamic raw;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        msg = json['message'],
        statusCode = json['statusCode'],
        raw = json['raw'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': msg,
        'statusCode': statusCode,
        'raw': raw,
      };
}
