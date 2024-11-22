import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/course.dart'; // Replace with the path to your Course model

class CourseManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  // Fetch courses from Firestore
  Future<void> fetchCourses() async {
    try {
      final querySnapshot = await _firestore.collection('courses').get();
      _courses = querySnapshot.docs.map((doc) {
        return Course.fromJson(doc.data() as Map<String, dynamic>)
          ..id = doc.id; // Assign Firestore document ID
      }).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching courses: $error');
    }
  }

  // Add a new course
  Future<void> addCourse(Course course) async {
    try {
      final docRef = await _firestore.collection('courses').add(course.toJson());
      course.id = docRef.id; // Update the course with Firestore ID
      _courses.add(course);
      notifyListeners();
    } catch (error) {
      print('Error adding course: $error');
    }
  }

  // Update an existing course
  Future<void> updateCourse(Course course) async {
    try {
      await _firestore.collection('courses').doc(course.id).update(course.toJson());
      final index = _courses.indexWhere((c) => c.id == course.id);
      if (index != -1) {
        _courses[index] = course;
        notifyListeners();
      }
    } catch (error) {
      print('Error updating course: $error');
    }
  }

  // Delete a course
  Future<void> deleteCourse(String courseId) async {
    try {
      await _firestore.collection('courses').doc(courseId).delete();
      _courses.removeWhere((course) => course.id == courseId);
      notifyListeners();
    } catch (error) {
      print('Error deleting course: $error');
    }
  }
}
