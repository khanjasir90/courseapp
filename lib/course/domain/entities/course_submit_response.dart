enum CourseSubmitResponseStatus {
  success,
  error,
}

class CourseSubmitResponse {

  CourseSubmitResponse({
    required this.status,
    required this.message,
  });

  CourseSubmitResponseStatus status;
  String message;

  factory CourseSubmitResponse.fromJson(Map<String, dynamic> json) {
    return CourseSubmitResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}