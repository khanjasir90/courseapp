import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/view/course_page.dart';
import 'package:courseapp/course/presentation/view/course_submit_view.dart';
import 'package:courseapp/course/presentation/widgets/lazy_list.dart';
import 'package:courseapp/transition_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CourseSearchView extends StatefulWidget {
  const CourseSearchView({super.key});

  @override
  State<CourseSearchView> createState() => _CourseSearchViewState();
}

class _CourseSearchViewState extends State<CourseSearchView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().searchCourses('');
    });
  }

  void _navigateToCoursePage() {
    Navigator.pushReplacement(
      context, 
      PageRouteUtil.createPageRoute(const CoursePage()));
    context.read<CourseProvider>().clearSelectedCourses();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Courses'),
        leading: IconButton(
          onPressed: () => _navigateToCoursePage(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SearchTextField(),
            CourseListView(),
          ],
        ),
      ),
      floatingActionButton: const FloatingButton(),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    void onChange(String query) {
      context.read<CourseProvider>().searchCourses(query);
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Courses',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: onChange,
      ),
    );
  }
}

class CourseListView extends StatelessWidget {
  const CourseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CourseProvider>(
        builder: (context, value, child) {
          if (value.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.status.isFailure) {
            return const Center(child: Text('Failed to load courses'));
          } else if (value.status.isSuccess &&
              (value.filteredCourses?.courses.isEmpty ?? true)) {
            return const Center(child: Text('Please search for a course'));
          } else if (value.status.isSuccess) {
            return LazyList(
              courses: value.filteredCourses!,
              isSelectionEnabled: value.isSelectionEnabled,
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

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
    return Consumer(builder: (context, CourseProvider provider, child) {
      if (provider.selectedCourseList.isNotEmpty) {
        return FloatingActionButton(
          onPressed: () => _navigateToSubmitPage(context),
          child: const Icon(Icons.arrow_forward),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}