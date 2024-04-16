import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fa9ran/controllers/category_controller.dart';
import 'package:fa9ran/ui/pages/inner_screens/inner_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoriesTile({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 110,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final CategoryController categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _scrollPosition += 100;
      if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
        _scrollPosition = 0;
      }
      _scrollController.animateTo(_scrollPosition,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = categoryController.categories;

      return Container(
        margin: const EdgeInsets.only(top: 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              (categories.length / 7)
                  .ceil(), // Calculate number of sets of 8 categories
              (setIndex) {
                final start = setIndex * 7;
                final end = (setIndex + 1) * 7;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: categories
                        .sublist(start,
                            end > categories.length ? categories.length : end)
                        .map((category) => InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return InnerCategoryScreen(
                                      categoryModel: category);
                                }));
                              },
                              child: CategoriesTile(
                                imageUrl: category.image,
                                title: category.categoryName,
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
