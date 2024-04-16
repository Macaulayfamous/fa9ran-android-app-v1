import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/ui/pages/widgets/productTile.dart';
import 'package:flutter/material.dart';

class BoysProductsWidget extends StatelessWidget {
  const BoysProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'Fashion')
        .where('subCategory', isEqualTo: 'Sp7Fl8ENoqsnRcU2FCEx')
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

        // Check if there are any documents
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No products available'),
          );
        }

        // Generate widget for the single product
        final productData = snapshot.data!.docs.first;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProductItem(productData: productData),
            ],
          ),
        );
      },
    );
  }
}
