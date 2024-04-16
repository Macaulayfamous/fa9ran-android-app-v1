import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/models/categories_models.dart';
import 'package:fa9ran/models/checked_model.dart';
import 'package:fa9ran/ui/pages/inner_screens/product_detail._screen.dart';
import 'package:fa9ran/ui/widgets/checked_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerSubCategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const InnerSubCategoryScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryModel.categoryName,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [related()],
      )),
    );
  }

  Widget related() {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryModel.categoryName)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Category'),
          );
        }
        return Container(
          child: GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 200 / 250),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(product: productData);
                      }));
                    },
                    child: CheckedTile(
                      Checked(
                        id: productData['productId'],
                        imageUrl: productData['imageUrl'][0],
                        name: productData['productName'],
                        title: 'Samsung',
                        price:
                            double.parse(productData['productPrice'].toString())
                                .toInt(),
                        discount: 1250,
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
