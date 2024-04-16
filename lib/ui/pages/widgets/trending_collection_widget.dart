import 'package:flutter/material.dart';

class TrendingCollectionWidget extends StatelessWidget {
  const TrendingCollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 232,
        width: 352,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/banner.png',
            ),
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  'Sneaker Collection',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10, left: 12),
                height: 39,
                width: 139,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Center(
                  child: Text(
                    'See ALL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
