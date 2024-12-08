import 'package:courseapp/course/data/model/course_model.dart';
import 'package:courseapp/course/domain/entities/course_submit_response.dart';
import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:courseapp/course/presentation/view/course_page.dart';
import 'package:courseapp/course/presentation/widgets/course_card.dart';
import 'package:courseapp/transition_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseSubmitView extends StatelessWidget {
  CourseSubmitView({super.key, required this.selectedCourse, required this.provider});


  final List<Course> selectedCourse;
  final CourseProvider provider;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void _navigaToCoursePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteUtil.createPageRoute(const CoursePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Selection'),
        leading: IconButton(
          onPressed: () {
            _navigaToCoursePage(context);
            context.read<CourseProvider>().clearSelectedCourses();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if(!_emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {

                      void showSnackBar(String message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message))
                        );
                        provider.clearSelectedCourses();
                        _navigaToCoursePage(context);
                      }

                      if (_formKey.currentState!.validate()){
                        final result = await provider.submitCourses(
                          _nameController.text,
                          _emailController.text,
                        );

                        if(result.status == CourseSubmitResponseStatus.success) {
                         showSnackBar('Course submitted successfully');
                        } else {
                          showSnackBar('Some error occurred');
                        }
                      }
                      
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: const Text("Selected Courses", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))), 
             const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedCourse.length,
                itemBuilder: (context, index) {
                  return CourseCard(
                    course: selectedCourse[index], 
                    onCourseSelected: (Course course){}, 
                    onCourseUnselected: (Course course){},
                    isSelectionEnabled: false,
                    provider: provider,
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}