class CourseResponse {
  final List<Course> courses;
  final int total;

  CourseResponse({required this.courses, required this.total});

  // Factory constructor to create a CourseResponse object from JSON
  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      courses: (json['courses'] as List)
          .map((course) => Course.fromJson(course))
          .toList(),
      total: json['total'],
    );
  }

  // Method to convert CourseResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'courses': courses.map((course) => course.toJson()).toList(),
      'total': total,
    };
  }
}

class Course {
  final int id;
  final String name;
  final String duration;

  Course({required this.id, required this.name, required this.duration});

  // Factory constructor to create a Course object from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
    );
  }

  // Method to convert Course object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
    };
  }
}
