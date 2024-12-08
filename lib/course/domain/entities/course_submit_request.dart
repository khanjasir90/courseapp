class CourseSubmitRequest {
  
  CourseSubmitRequest({
    required this.name,
    required this.email,
    required this.courseIds,
  });
  
  String name;
  String email;
  List<int> courseIds;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'courseIds': courseIds,
    };
  }

  factory CourseSubmitRequest.fromJson(Map<String, dynamic> json) {
    return CourseSubmitRequest(
      name: json['name'],
      email: json['email'],
      courseIds: (json['courseIds'] as List).map((courseId) => courseId as int).toList(),
    );
  }
}