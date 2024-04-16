import 'package:cached_network_image/cached_network_image.dart';
import 'package:fa9ran/controllers/fashion_controller.dart';
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
                )),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 100,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class FashionPage extends StatelessWidget {
  const FashionPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final FashionController categoryController =
        Get.find<FashionController>();

    return Obx(() {
      final categories = categoryController.categories;

      return Container(
        margin: const EdgeInsets.only(top: 6),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return InnerCategoryScreen(
                                //       categoryModel: category);
                                // }));
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
}
