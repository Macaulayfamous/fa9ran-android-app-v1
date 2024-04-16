import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa9ran/models/search_model.dart';
import 'package:fa9ran/ui/pages/inner_screens/product_detail._screen.dart';
import 'package:fa9ran/ui/widgets/search_items.dart';
import 'package:fa9ran/ui/widgets/search_products.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 9),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15.75, top: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/arrow_left.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 5),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      autofocus:
                          true, // Automatically focuses the field when page is opened
                      onChanged: (value) {
                        setState(() {
                          searchedValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 37.5),
                        hintText: 'Search here ...',
                        hintStyle: const TextStyle(
                          color: Color(0xffC8C8CB),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xffE41937),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 24,
                          color: Color(0xffC8C8CB),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7, right: 13, left: 7.5),
                    child: Image.asset(
                      'assets/Buy.png',
                      height: 26,
                      width: 26,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              )
            ],
          ),
          toolbarHeight: 95.0,
        ),
      );
    }

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Text(
                'Last Search',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: const Text(
                'Clear All',
                style: TextStyle(
                    color: Color(0xffD65B5B),
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      );
    }

    Widget emptySearch() {
      final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
          .collection('products')
          .where('popular', isEqualTo: true)
          .limit(5)
          .snapshots();

      return Container(
        margin: const EdgeInsets.only(top: 18, left: 23, right: 28.5),
        child: StreamBuilder<QuerySnapshot>(
          stream: productStream, // Limiting to 5 documents
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(product: data);
                        }));
                      },
                      child: SearchItems(
                          Search(id: 1, name: data['productName']))),
                );
              }).toList(),
            );
          },
        ),
      );
    }

    Widget intro() {
      return Container(
        margin: const EdgeInsets.only(left: 25, right: 19),
        child: Row(
          children: [
            Text(
              searchedValue == ''
                  ? 'Popular items'
                  : 'Search result for "Household"',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 90,
            ),
            // Container(
            //   height: 35,
            //   width: 90,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(9),
            //     border: Border.all(color: Colors.grey),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text(
            //         'Filters',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 12.75,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 15,
            //       ),
            //       Image.asset(
            //         'assets/Filter.png',
            //         height: 13,
            //         width: 13,
            //         fit: BoxFit.cover,
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget content() {
      return StreamBuilder<QuerySnapshot>(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final searchData = snapshot.data!.docs.where((element) {
            return element['productName']
                .toLowerCase()
                .contains(searchedValue.toLowerCase());
          }).toList();

          if (searchedValue.isEmpty) {
            return emptySearch();
          }
          return Container(
            margin: const EdgeInsets.only(top: 19.75, right: 27.75),
            child: Column(
              children: searchData.map((e) {
                // Check if e['productPrice'] is an integer
                bool isInteger = e['productPrice'] is int;

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(product: e);
                      }));
                      print('Product Price: ${e['productPrice']}');
                    },
                    child: SearchProducts(
                      id: 1,
                      name: e['productName'],
                      imageUrl: e['imageUrl'][0],
                      price: isInteger
                          ? e['productPrice']
                          : 50, // Use e['productPrice'] if it's an integer, else use 50
                      model: e['category'],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      );
    }

    Widget image() {
      return Container(
        margin: const EdgeInsets.only(top: 56),
        child: Column(
          children: [
            Image.asset(
              'assets/empty.png',
              height: 313,
              width: 313,
              fit: BoxFit.cover,
            ),
            const Text(
              'No Results Found',
              style: TextStyle(
                color: Color(0xff595959),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            //title(),
            //emptySearch(),
            intro(),
            content(),
            //image(),
          ],
        ),
      ),
    );
  }
}
