import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/ui/pages/widgets/productTile.dart';
import 'package:flutter/material.dart';

class TrendingProducts extends StatelessWidget {
  const TrendingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
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