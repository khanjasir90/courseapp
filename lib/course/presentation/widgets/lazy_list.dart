import 'package:courseapp/course/data/model/course_model.dart';
import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LazyList extends StatefulWidget {
  const LazyList({super.key, required this.courses, required this.isSelectionEnabled});

  final CourseResponse courses;
  final bool isSelectionEnabled;

  @override
  State<LazyList> createState() => _LazyListState();
}

class _LazyListState extends State<LazyList> {

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(_fetchNextPage);
  }

  void _fetchNextPage() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final provider = context.read<CourseProvider>();
      provider.getAllCourses((provider.courses?.courses.length ?? 10)+ 10);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_fetchNextPage);
    _scrollController.dispose();
    super.dispose();
  }

  void _onCourseSelected(Course course) {
    final provider = context.read<CourseProvider>();
    provider.addCourse(course);
  }

  void _onCourseUnSelected(Course course) {
    final provider = context.read<CourseProvider>();
    provider.removeCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: widget.courses.courses.length,
            itemBuilder: (context, index) {
              final Course course = widget.courses.courses[index];
              return CourseCard(
                course: course,
                onCourseSelected: _onCourseSelected,
                onCourseUnselected: _onCourseUnSelected,
                isSelectionEnabled: widget.isSelectionEnabled,
                provider: context.read<CourseProvider>(),
              );
            },
          ),
        ),
      ],
    );
  }
}