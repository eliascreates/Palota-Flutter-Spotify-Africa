import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String imageUrl;
  final String categoryId;
  final String categoryType;

  const CategoryHeader({
    super.key,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.only(left: 24, top: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF211F26),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 64,
              width: 64,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${categoryId[0].toUpperCase() + categoryId.substring(1)} ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: '${categoryType}s',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
