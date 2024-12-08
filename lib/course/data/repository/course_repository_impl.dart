import 'package:courseapp/core/network/api_result.dart';
import 'package:courseapp/core/network/api_result_failure.dart';
import 'package:courseapp/core/network/api_result_success.dart';
import 'package:courseapp/course/data/data_source/mock_source.dart';
import 'package:courseapp/course/domain/entities/course_submit_request.dart';
import 'package:courseapp/course/domain/entities/course_submit_response.dart';
import 'package:courseapp/course/domain/repository/course_repository.dart';
import 'package:courseapp/course/utils/search.dart';

import '../model/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final MockCourseSource courseDataSource;
  final Search searchUtil;

  CourseRepositoryImpl({required this.courseDataSource, required this.searchUtil});

  @override
  Future<ApiResult<CourseResponse>> getAllCourses(int index) async {
    try {
      final courses = CourseResponse.fromJson(await courseDataSource.getAllCourses());
      if(index > courses.courses.length) {
        return Future.value(ApiSuccess(data: CourseResponse(courses: courses.courses, total: courses.courses.length)));
      }
      final paginatedCourses = courses.courses.sublist(0,index);
      return Future.value(ApiSuccess(data: CourseResponse(courses: paginatedCourses, total: paginatedCourses.length)));
    } catch (e) {
      return Future.value(ApiFailure(msg: e.toString()));
    }
  }

  @override
  Future<ApiResult<CourseResponse>> searchCourses(String query) async {
    try {
      final courses = CourseResponse.fromJson(await courseDataSource.searchCourses(query));
      final filteredSearch = searchUtil.searchCourses(courses, query);
      return Future.value(ApiSuccess(data: filteredSearch));
    } catch(e) {
      return Future.value(ApiFailure(msg: e.toString()));
    }
  }

  @override
  Future<ApiResult<CourseSubmitResponse>> submitCourse(CourseSubmitRequest request) {
    if(request.email.isNotEmpty && request.name.isNotEmpty && request.courseIds.isNotEmpty) {
      return Future.value(ApiSuccess(data: CourseSubmitResponse(message: 'Course submitted successfully', status: CourseSubmitResponseStatus.success)));
    } else {
      return Future.value(ApiFailure(msg: 'Invalid request'));
    }
  }

}