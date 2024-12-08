

import '../data/model/course_model.dart';

abstract class Search {

  CourseResponse searchCourses(CourseResponse courses, String query);
}

class SearchImpl extends Search {

  @override
  CourseResponse searchCourses(CourseResponse courses, String query) {
    final List<Course> searchResults = [];

    query = query.trim();

    if(query.isEmpty) {
      return CourseResponse(courses: [], total: 0);
    }

    for(final course in courses.courses) {
      if(course.name.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(course);
      }
    }

    return CourseResponse(courses: searchResults, total: searchResults.length);
  }
}