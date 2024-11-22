import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';

class LessonManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Lesson> _lessons = [];
  List<Lesson> get lessons => _lessons;

  // Fetch lessons for a specific course
  Future<void> fetchLessons(String courseId) async {
    try {
      final querySnapshot = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .get();
      _lessons = querySnapshot.docs.map((doc) {
        return Lesson.fromJson(doc.data())
          ..id = doc.id; // Assign Firestore document ID
      }).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching lessons: $error');
    }
  }

  // Add a new lesson
  Future<void> addLesson(String courseId, Lesson lesson) async {
    try {
      final docRef = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .add(lesson.toJson());
      lesson.id = docRef.id; // Update the lesson with Firestore ID
      _lessons.add(lesson);
      notifyListeners();
    } catch (error) {
      print('Error adding lesson: $error');
    }
  }

  // Update an existing lesson
  Future<void> updateLesson(String courseId, Lesson lesson) async {
    try {
      await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lesson.id)
          .update(lesson.toJson());
      final index = _lessons.indexWhere((l) => l.id == lesson.id);
      if (index != -1) {
        _lessons[index] = lesson;
        notifyListeners();
      }
    } catch (error) {
      print('Error updating lesson: $error');
    }
  }

  // Delete a lesson
  Future<void> deleteLesson(String courseId, String lessonId) async {
    try {
      await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .delete();
      _lessons.removeWhere((lesson) => lesson.id == lessonId);
      notifyListeners();
    } catch (error) {
      print('Error deleting lesson: $error');
    }
  }
}
