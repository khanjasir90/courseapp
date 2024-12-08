import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/view/course_search_view.dart';
import 'package:courseapp/course/presentation/view/course_submit_view.dart';
import 'package:courseapp/course/presentation/view/course_view.dart';
import 'package:courseapp/transition_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  void _navigateToSearchPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteUtil.createPageRoute(const CourseSearchView()),
    );
  }

  void _navigateToSubmitPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteUtil.createPageRoute(
        CourseSubmitView(
          selectedCourse: context.read<CourseProvider>().selectedCourseList,
          provider: context.read<CourseProvider>(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course App'),
        actions: [
          IconButton(
            onPressed: () => _navigateToSearchPage(context),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const CourseView(),
      floatingActionButton: 
      Consumer(builder: (context, CourseProvider provider, child) {
        if(provider.selectedCourseList.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () => _navigateToSubmitPage(context),
            child: const Icon(Icons.arrow_forward),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
