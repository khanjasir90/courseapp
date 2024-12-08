import 'package:courseapp/course/data/model/course_model.dart';
import 'package:courseapp/course/utils/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockCourseResponse extends Mock implements CourseResponse {}

void main() {
  late SearchImpl searchImpl;

  setUp(() {
    searchImpl = SearchImpl();
  });

  group('SearchImpl searchCourses', () {
    test('Empty search query returns empty result', () {
      // Arrange
      const query = '';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isEmpty);
      expect(result.total, 0);
    });

    test('No matching courses for the search query', () {
      // Arrange
      const query = 'Non-existing course';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isEmpty);
      expect(result.total, 0);
    });

    test('Exact match for the search query (case-insensitive)', () {
      // Arrange
      const query = 'Flutter Basics';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'Flutter Basics');
      expect(result.total, 1);
    });

    test('Partial match for the search query (case-insensitive)', () {
      // Arrange
      const query = 'flutter';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'Flutter Basics');
      expect(result.total, 1);
    });

    test('Multiple matching courses for the search query', () {
      // Arrange
      const query = 'course';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics course', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain for Beginners course', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 2);
      expect(result.total, 2);
    });

    test('Multiple words in the query', () {
      // Arrange
      const query = 'flutter basics';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'Machine Learning', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'Flutter Basics');
      expect(result.total, 1);
    });

    test('Exact match with special characters in course name', () {
      // Arrange
      const query = 'UI/UX Design';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'UI/UX Design', duration: '4 weeks'),
        Course(id: 2, name: 'Blockchain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'UI/UX Design');
      expect(result.total, 1);
    });

    test('Search query with spaces', () {
      // Arrange
      const query = '  Flutter Basics  ';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'Machine Learning', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'Flutter Basics');
      expect(result.total, 1);
    });

    test('Search query with mixed case', () {
      // Arrange
      const query = 'FLUTTER';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics', duration: '4 weeks'),
        Course(id: 2, name: 'BlockChain', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'Flutter Basics');
      expect(result.total, 1);
    });

    test('Single course match', () {
      // Arrange
      const query = 'AI';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'AI', duration: '4 weeks'),
        Course(id: 2, name: 'Machine Learning', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'AI');
      expect(result.total, 1);
    });

    test('All courses match', () {
      // Arrange
      const query = 'course';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'Flutter Basics course', duration: '4 weeks'),
        Course(id: 2, name: 'AI course', duration: '4 weeks'),
        Course(id: 3, name: 'Machine Learning course', duration: '6 weeks'),
        Course(id: 4, name: 'Blockchain course', duration: '4 weeks'),
      ], total: 4);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 4);
      expect(result.total, 4);
    });

    test('Performance with large number of courses', () {
      // Arrange
      const query = '2';
      final courses = CourseResponse(courses: List.generate(1000, (index) => Course(
          id: index,
          name: 'Course $index',
          duration: 'Duration $index',
      )), total: 1000);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isNotEmpty);
      expect(result.total, isNonZero);
    });

    test('Search query with non-alphabetic characters', () {
      // Arrange
      const query = 'AI 2021';
      final courses = CourseResponse(courses: [
        Course(id: 1, name: 'AI 2021', duration: '4 weeks'),
        Course(id: 2, name: 'AI 2020', duration: '6 weeks'),
      ], total: 2);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses.length, 1);
      expect(result.courses[0].name, 'AI 2021');
      expect(result.total, 1);
    });

    test('Search query with empty course data', () {
      // Arrange
      const query = 'AI';
      final courses = CourseResponse(courses: [], total: 0);

      // Act
      final result = searchImpl.searchCourses(courses, query);

      // Assert
      expect(result.courses, isEmpty);
      expect(result.total, 0);
    });
  });
}
