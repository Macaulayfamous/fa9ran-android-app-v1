import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/ui/pages/widgets/productTile.dart';
import 'package:flutter/material.dart';

class GirlsProductsWidget extends StatelessWidget {
  const GirlsProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'Fashion')
        .where('subCategory', isEqualTo: '2ABTczOS5Dj2v6c4NAXA')
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  final productData = snapshot.data!.docs[index];
                  return ProductItem(productData: productData);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
