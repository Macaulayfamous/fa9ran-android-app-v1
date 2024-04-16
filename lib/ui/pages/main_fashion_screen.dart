import 'package:fa9ran/ui/pages/fashion_page.dart';
import 'package:fa9ran/ui/pages/widgets/banner_widget.dart';
import 'package:fa9ran/ui/pages/widgets/boys_fashion_widget.dart';
import 'package:fa9ran/ui/pages/widgets/fashion_search_widget.dart';
import 'package:fa9ran/ui/pages/widgets/popular_fashion_products.dart';
import 'package:fa9ran/ui/pages/widgets/text_title.dart';
import 'package:flutter/material.dart';

class MainFashionScreen extends StatelessWidget {
  const MainFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FashionSearchWidget(),
            SizedBox(),
             BannerArea(),
            SizedBox(
              height: 15,
            ),
             FashionPage(),
            TextTitleWidget(title: "Girls' Fashion", subtitle: 'see all'),
            GirlsProductsWidget(),
            TextTitleWidget(title: "Boys' Fashion", subtitle: 'see all'),
            BoysProductsWidget(),
          ],
        ),
      ),
    );
  }
}
