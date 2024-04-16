

import 'package:flutter/material.dart';

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Container(
          height: 133,
          width: 352,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 13.5),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 33.5,
                    ),
                    Text(
                      '40%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29.7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'NEW COLLECTION WITH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 75,
                ),
                Image.asset(
                  'assets/airpods.png',
                  height: 135.5,
                  width: 144.6,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      );
  }
}