
import 'package:animated_dashed_circle/animated_dashed_circle.dart';
import 'package:flutter/material.dart';

class CircleStory extends StatelessWidget {
  final String image;
  final String name;
  const CircleStory({
    super.key, required this.image, required this.name
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.0,
      child: Column(
        children: [
          const SizedBox(
            height: 3.0,
          ),
          AnimatedDashedCircle().show(
            image: AssetImage(image),
            autoPlay: true,
            contentPadding: 2,
            height: 54.0,
            borderWidth: 5,
          ),
          const SizedBox(height: 4.0),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}