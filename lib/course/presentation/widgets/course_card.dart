import 'package:courseapp/course/data/model/course_model.dart';
import 'package:courseapp/course/presentation/provider/course_provider.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.onCourseSelected,
    required this.onCourseUnselected,
    required this.isSelectionEnabled,
    required this.provider,
  });

  final Course course;
  final Function(Course) onCourseSelected;
  final Function(Course) onCourseUnselected;
  final bool isSelectionEnabled;
  final CourseProvider provider;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isSelected = false;

  void _toggleSelection(bool? isSelected) {
    if (isSelected == true) {
      widget.onCourseSelected(widget.course);
    } else {
      widget.onCourseUnselected(widget.course);
    }
    setState(() {
      _isSelected = isSelected ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              widget.course.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            widget.course.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            widget.course.duration,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          trailing: widget.isSelectionEnabled
              ? Checkbox(
                  value: _isSelected,
                  onChanged: _toggleSelection,
                )
              : null,
        ),
      ),
    );
  }
}
