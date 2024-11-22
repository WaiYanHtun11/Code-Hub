import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
class ResourceManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Resource> _resources = [];
  List<Resource> get resources => _resources;

  // Fetch resources for a specific lesson
  Future<void> fetchResources(String courseId, String lessonId) async {
    try {
      final querySnapshot = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .collection('resources')
          .get();
      _resources = querySnapshot.docs.map((doc) {
        return Resource.fromJson(doc.data())
          ..id = doc.id; // Assign Firestore document ID
      }).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching resources: $error');
    }
  }

  // Add a new resource
  Future<void> addResource(String courseId, String lessonId, Resource resource) async {
    try {
      final docRef = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .collection('resources')
          .add(resource.toJson());
      resource.id = docRef.id; // Update the resource with Firestore ID
      _resources.add(resource);
      notifyListeners();
    } catch (error) {
      print('Error adding resource: $error');
    }
  }

  // Update an existing resource
  Future<void> updateResource(
      String courseId, String lessonId, Resource resource) async {
    try {
      await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .collection('resources')
          .doc(resource.id)
          .update(resource.toJson());
      final index = _resources.indexWhere((r) => r.id == resource.id);
      if (index != -1) {
        _resources[index] = resource;
        notifyListeners();
      }
    } catch (error) {
      print('Error updating resource: $error');
    }
  }

  // Delete a resource
  Future<void> deleteResource(String courseId, String lessonId, String resourceId) async {
    try {
      await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('lessons')
          .doc(lessonId)
          .collection('resources')
          .doc(resourceId)
          .delete();
      _resources.removeWhere((resource) => resource.id == resourceId);
      notifyListeners();
    } catch (error) {
      print('Error deleting resource: $error');
    }
  }
}
