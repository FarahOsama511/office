import '../constants/error_message.dart';

class ApiErrorModel {
  final ApiErrorType type;
  final int? statusCode;
  ApiErrorModel({required this.type, this.statusCode});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      type: json['message'] ?? 'An unknown error occurred',
      statusCode: json['statusCode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'message': type, 'statusCode': statusCode};
  }
}
