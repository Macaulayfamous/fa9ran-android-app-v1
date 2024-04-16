import 'package:cached_network_image/cached_network_image.dart';
import 'package:fa9ran/models/checked_model.dart';
import 'package:flutter/material.dart';

class CheckedTile extends StatelessWidget {
  final Checked checked;
  const CheckedTile(this.checked, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: SizedBox(
          width: 171,
          height: 170,
          child: CachedNetworkImage(
            imageUrl: checked.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(
        height: 2,
      ),
      Flexible(
        child: Container(
          padding: const EdgeInsets.only(right: 13.0),
          child: Text(
            checked.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.0,
              fontFamily: 'Roboto',
              color: Color(0xFF212121),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      Row(
        children: [
          Text(
            '\$${checked.price}',
            style: const TextStyle(
              color: Color(0xffFA254C),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '\$${checked.discount}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(
            height: 3.5,
          ),
        ],
      ),
      Text(
        checked.title,
        style: const TextStyle(
          color: Color(0xff868D94),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ]);
  }
}
