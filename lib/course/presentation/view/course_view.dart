import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/widgets/lazy_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, value, child) {
        if (value.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.status.isFailure) {
          return const Center(child: Text('Failed to load courses'));
        } else if (value.status.isSuccess) {
          return LazyList(
            courses: value.courses!,
            isSelectionEnabled: value.isSelectionEnabled,
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
