import 'package:flutter/material.dart';
import 'package:nexacloth/components/apptextstyle.dart';

class CustomHomeHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  const CustomHomeHeader({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            imageUrl,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!', style: AppTextStyle.subtextMedium),
            Text('${title ?? "NexaCloth"}', style: AppTextStyle.h6),
          ],
        ),
        const Spacer(),
        const Icon(Icons.notifications),
      ],
    );
  }
}
