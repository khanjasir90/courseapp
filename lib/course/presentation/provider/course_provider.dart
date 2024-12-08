import 'package:courseapp/core/network/api_result_success.dart';
import 'package:courseapp/course/data/model/course_model.dart';
import 'package:courseapp/course/domain/entities/course_submit_request.dart';
import 'package:courseapp/course/domain/entities/course_submit_response.dart';
import 'package:courseapp/course/domain/repository/course_repository.dart';
import 'package:flutter/material.dart';

enum ApiStatus {
  initial,
  loading,
  success,
  failure,
}

extension ApiStatusX on ApiStatus {
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isFailure => this == ApiStatus.failure;
  bool get isInitial => this == ApiStatus.initial;
}


class CourseProvider extends ChangeNotifier {

  CourseProvider({required this.courseRepository}) {
    Future.microtask(() => getAllCourses(10));
  }
  
  final CourseRepository courseRepository;

  ApiStatus _status = ApiStatus.initial;

  CourseResponse? _courses;

  CourseResponse? _filteredCourses;

  CourseResponse? get courses => _courses;

  CourseResponse? get filteredCourses => _filteredCourses;

  List<Course> _selectedCourseList = [];


  List<Course> get selectedCourseList => _selectedCourseList;

  bool _isSelectionEnabled = true;

  bool get isSelectionEnabled => _isSelectionEnabled;

  void toggleSelection() {
    _isSelectionEnabled = !_isSelectionEnabled;
    clearSelectedCourses();
    notifyListeners();
  }

  ApiStatus get status => _status;

  void _setStatus(ApiStatus status) {
    _status = status;
    notifyListeners();
  }


  Future<void> getAllCourses(int index) async {
    _setStatus(ApiStatus.loading);
    
    final result = await courseRepository.getAllCourses(index);
    
    if(result is ApiSuccess) {
      _courses = result.data as CourseResponse;
      _setStatus(ApiStatus.success);
    } else {
      _setStatus(ApiStatus.failure);
    }
  }

  void addCourse(Course course) {
    _selectedCourseList.add(course);
    notifyListeners();
  }

  void removeCourse(Course course) {
    _selectedCourseList.removeWhere((element) => element.id == course.id);
    notifyListeners();
  }

  void clearSelectedCourses() {
    _selectedCourseList.clear();
    notifyListeners();
  }

  Future<void> searchCourses(String query) async {
    _setStatus(ApiStatus.loading);
    
    final result = await courseRepository.searchCourses(query);
    
    if(result is ApiSuccess) {
      _filteredCourses = result.data as CourseResponse;
      _setStatus(ApiStatus.success);
    } else {
      _setStatus(ApiStatus.failure);
    }
  }

  Future<CourseSubmitResponse> submitCourses(String name, String email) async {
    _setStatus(ApiStatus.loading);

    final courseIds = _selectedCourseList.map((e) => e.id).toList();

    final CourseSubmitRequest request = CourseSubmitRequest(
      name: name,
      email: email,
      courseIds: courseIds,
    );

    final result = await courseRepository.submitCourse(request);

    if(result is ApiSuccess) {
      _setStatus(ApiStatus.success);
    } else {
      _setStatus(ApiStatus.failure);
    }

    return result.data as CourseSubmitResponse;
  }
}