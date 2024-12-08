abstract class ApiResult<T> {
  T? data;
  String? errorMessage;

  ApiResult({this.data, this.errorMessage});
}