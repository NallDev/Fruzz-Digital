import 'package:animated_dashed_circle/animated_dashed_circle.dart';
import 'package:flutter/material.dart';

class CircleStory extends StatelessWidget {
  final String image;
  final String name;

  const CircleStory({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.0,
      child: Column(
        children: [
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red, // Border color
                width: 2.0, // Border width
              ),
            ),
            child: ClipOval(
              child: Padding(
                padding: EdgeInsets.all(2.0), // The transparent space width
                child: ClipOval(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
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
