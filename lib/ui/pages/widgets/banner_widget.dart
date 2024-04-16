import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/banner.dart';

class BannerArea extends StatelessWidget {
  const BannerArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.find<BannerController>();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: bannerController.getBannerUrls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (snapshot.hasError) {
          if (kDebugMode) {
            print('Error fetching banners: ${snapshot.error}');
          }
          return const Icon(Icons.error);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          if (kDebugMode) {
            print('No banners found.');
          }
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
          // Extract banner URLs from the list of maps
          final List<String> bannerUrls =
              snapshot.data!.map((e) => e['image'] as String).toList();
          final List<String> pageValues =
              snapshot.data!.map((e) => e['page'] as String).toList();
          print(pageValues);
          return InkWell(child: BannerWidget(bannerUrls: bannerUrls));
        }
      },
    );
  }
}

class BannerWidget extends StatefulWidget {
  final List<String> bannerUrls;

  const BannerWidget({Key? key, required this.bannerUrls}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: CarouselSlider.builder(
              itemCount: widget.bannerUrls.length,
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return CachedNetworkImage(
                  imageUrl: widget.bannerUrls[index],
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Adjust the height as needed
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.bannerUrls.length,
                (index) => _buildPageIndicator(index),
              ),
            ),
          ),
        ],
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
            width: 16.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.blue, // Indicator color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // Shadow position
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
