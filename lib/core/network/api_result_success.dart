import 'package:courseapp/core/network/api_result.dart';

class ApiSuccess<T> extends ApiResult<T> {
  ApiSuccess({required T data}) : super(data: data);
}