import 'package:courseapp/core/network/api_result.dart';

class ApiFailure<T> extends ApiResult<T> {
  String? msg;

  ApiFailure({required String msg}) : super(errorMessage : msg); 
} 