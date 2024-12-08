import 'package:courseapp/course/data/data_source/mock_source.dart';
import 'package:courseapp/course/data/repository/course_repository_impl.dart';
import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/view/course_page.dart';
import 'package:courseapp/course/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CourseProvider(
            courseRepository: CourseRepositoryImpl(
              courseDataSource: MockCourseSourceImpl(),
              searchUtil: SearchImpl(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursePage(),
    );
  }
}
