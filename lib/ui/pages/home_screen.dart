import 'package:fa9ran/ui/pages/widgets/banner_widget.dart';
import 'package:fa9ran/ui/pages/widgets/category_item.dart';
import 'package:fa9ran/ui/pages/widgets/collection_widget.dart';
import 'package:fa9ran/ui/pages/widgets/location_widget.dart';
import 'package:fa9ran/ui/pages/widgets/popular_products_widget.dart';
import 'package:fa9ran/ui/pages/widgets/productTile.dart';
import 'package:fa9ran/ui/pages/widgets/text_title.dart';
import 'package:fa9ran/ui/pages/widgets/trending_collection_widget.dart';
import 'package:fa9ran/ui/pages/widgets/trending_products_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.20),
        child: const LocationWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerArea(),

            const TextTitleWidget(title: 'Categories', subtitle: 'See all'),
            const CategoryItem(),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            // DiscountBanner(), // Uncomment if needed
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const TextTitleWidget(
              title: 'Best Sales',
              subtitle: 'See all',
            ),
            const ProductDisplay(),

            SizedBox(
              height: screenHeight * 0.03, // Reduce the gap here
            ),
            const CollectionWidget(),
            const TextTitleWidget(
              title: 'Trending Products',
              subtitle: 'See all',
            ),

            const TrendingProducts(),
            SizedBox(
              height: screenHeight * 0.03, // Reduce the gap here
            ),

            const TrendingCollectionWidget(),

            const TextTitleWidget(
              title: 'Popular Products',
              subtitle: 'See all',
            ),

            const PopularProducts(),
          ],
        ),
      ),
    );
  }
}
