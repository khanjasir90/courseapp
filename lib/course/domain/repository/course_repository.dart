import 'package:courseapp/core/network/api_result.dart';
import 'package:courseapp/course/domain/entities/course_submit_request.dart';
import 'package:courseapp/course/domain/entities/course_submit_response.dart';

import '../../data/model/course_model.dart';


abstract class CourseRepository {
  Future<ApiResult<CourseResponse>> getAllCourses(int index);
  Future<ApiResult<CourseResponse>> searchCourses(String query);
  Future<ApiResult<CourseSubmitResponse>> submitCourse(CourseSubmitRequest request);
}