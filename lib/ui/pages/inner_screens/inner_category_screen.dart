import 'package:cached_network_image/cached_network_image.dart';
import 'package:fa9ran/controllers/all_category_banner.dart';
import 'package:fa9ran/models/categories_models.dart';
import 'package:fa9ran/ui/pages/cart_page.dart';
import 'package:fa9ran/ui/pages/categories_page.dart';
import 'package:fa9ran/ui/pages/inner_screens/inner_best_product.dart';
import 'package:fa9ran/ui/pages/inner_screens/inner_popular_product.dart';
import 'package:fa9ran/ui/pages/inner_screens/inner_trending_product.dart';
import 'package:fa9ran/ui/pages/inner_screens/subcategories_widget.dart';
import 'package:fa9ran/ui/pages/main_fashion_screen.dart';
import 'package:fa9ran/ui/pages/main_page.dart';
import 'package:fa9ran/ui/pages/profile_page.dart';
import 'package:fa9ran/ui/pages/widgets/banner_widget.dart';
import 'package:fa9ran/ui/pages/widgets/collection_widget.dart';
import 'package:fa9ran/ui/pages/widgets/fashion_search_widget.dart';
import 'package:fa9ran/ui/pages/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InnerCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const InnerCategoryScreen({super.key, required this.categoryModel});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int _pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });

    // Navigate to the corresponding screen based on the selected index
    switch (index) {
      case 0:
        // Navigate to HomeScreen
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPage()));
        break;
      case 1:
        // Navigate to CategoriesPage
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CategoriesPage()));
        break;
      case 2:
        // Navigate to MainFashionScreen
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainFashionScreen()));
        break;
      case 3:
        // Navigate to CartPage
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CartPage()));
        break;
      case 4:
        // Navigate to ProfilePage
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      // Handle other cases here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FashionSearchWidget(),
            const SizedBox(
              height: 10,
            ),
            _displayBanner(context),
            const SizedBox(
              height: 10,
            ),
            const TextTitleWidget(title: 'Subcategories', subtitle: ''),
            const SizedBox(
              height: 10,
            ),
            SubCategoryWidget(
              categoryName: widget.categoryModel.categoryName,
            ),
            const SizedBox(
              height: 10,
            ),
            const TextTitleWidget(title: 'Best Sales', subtitle: 'See all'),
            InnerBestProduct(categoryName: widget.categoryModel.categoryName),
            const SizedBox(
              height: 10,
            ),
            const TextTitleWidget(
              title: 'Trending Products',
              subtitle: 'See all',
            ),
            const SizedBox(
              height: 10,
            ),
            const CollectionWidget(),
            const SizedBox(
              height: 10,
            ),
            InnerTrendingProducts(
                categoryName: widget.categoryModel.categoryName),
            const SizedBox(
              height: 10,
            ),
            const BannerArea(),
            const TextTitleWidget(
              title: 'Popular Products',
              subtitle: 'See all',
            ),
            InnerPopularProduct(categoryName: widget.categoryModel.categoryName)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: _onItemTapped,
          unselectedLabelStyle: const TextStyle(
            color: Color(0xff484C52),
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
          ),
          selectedLabelStyle: const TextStyle(
            color: Color(0xffE41937),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
          selectedItemColor: const Color(0xffE41937),
          unselectedItemColor: const Color(0xff484C52),
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/home-2.png',
                width: 67.5,
                height: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Palette1.png',
                height: 24,
                width: 24,
              ),
              label: 'categories',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/brand 1.png',
                height: 24,
                width: 60,
              ),
              label: 'Fashion',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Cart1.png',
                height: 24,
                width: 24,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/User1.png',
                height: 24,
                width: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayBanner(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width < 600 ? 16.0 : 32.0;

    final AllCategoryBannerController bannerController =
        Get.find<AllCategoryBannerController>();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170, // Adjust the banner height as needed
        padding: EdgeInsets.symmetric(horizontal: spacing),

        child: StreamBuilder<List<String>>(
          stream:
              bannerController.getBannerUrls(widget.categoryModel.categoryName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (snapshot.hasError) {
              print('Error fetching banners: ${snapshot.error}');
              return const Icon(Icons.error);
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              print('No banners found.');
              return const Center(
                child: Text(
                  'No banners available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                          child: CachedNetworkImage(
                        imageUrl: snapshot.data![index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ));
                    },
                  ),
                  _buildPageIndicator(snapshot.data!.length),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Indicator color
            ),
          );
        }),
      ),
    );
  }
}
