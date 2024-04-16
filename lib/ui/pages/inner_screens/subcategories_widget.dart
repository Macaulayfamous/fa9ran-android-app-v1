import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/models/sub_category_models.dart';
import 'package:fa9ran/ui/pages/inner_screens/inner_sub_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;

  const SubCategoryWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  double _scrollPosition = 0.0;
  bool _reverse = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _scrollPosition += _reverse ? -100 : 100;
      if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
        _reverse = true;
      } else if (_scrollPosition <=
          _scrollController.position.minScrollExtent) {
        _reverse = false;
      }
      _scrollController.animateTo(_scrollPosition,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('subcategories')
        .where('categoryName', isEqualTo: widget.categoryName)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: List.generate(
              docs.length,
              (index) {
                final subdata = SubCategoryModel(
                  categoryName: docs[index][
                      'categoryName'], // Assuming 'categoryName' is a field in your Firestore document
                  image: docs[index]['image'][
                      0], // Assuming 'image' is a field in your Firestore document
                  subcategoryId: docs[index]['subcategoryId'],
                  subcategoryName: docs[index]['subcategoryName'],
                );

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InnerSubProductsScreen(
                            subId: subdata.subcategoryId,
                            subcategoryName: subdata.subcategoryName,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
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
                              imageUrl: subdata.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 100,
                          child: Text(
                            subdata.categoryName,
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
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
