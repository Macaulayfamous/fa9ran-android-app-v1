import 'package:fa9ran/models/categories_models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InnerSubcategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;



   fetchCategories(String categoryName) {
    _firestore
        .collection('subcategories')
        .where('categoryName', isEqualTo: categoryName)
        .snapshots()
        .listen((querySnapshot) {
      categories.assignAll(
        querySnapshot.docs.map((doc) {
          final data = doc.data();
          return CategoryModel(
            categoryName: data['subcategoryName'],
            image: data['image'][0],
          );
        }).toList(),
      );
    }, onError: (error) {
      if (kDebugMode) {
        print("Error fetching categories: $error");
      }
    });
  }
}
