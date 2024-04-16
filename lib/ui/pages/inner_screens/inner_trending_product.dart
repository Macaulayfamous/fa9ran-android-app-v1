import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/ui/pages/widgets/productTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerTrendingProducts extends StatelessWidget {
  final String categoryName;

  const InnerTrendingProducts({super.key, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .where('trending', isEqualTo: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

         if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No enough Data  to show',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(snapshot.data!.docs.length, (index) {
              final productData = snapshot.data!.docs[index];
              return ProductItem(productData: productData);
            }),
          ),
        );
      },
    );
  }
}
