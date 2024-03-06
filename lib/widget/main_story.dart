
import 'package:flutter/material.dart';

import '../theme/text_style.dart';

class MainStory extends StatelessWidget {
  final String name;
  final String image;
  final String description;

  const MainStory({
    super.key, required this.name, required this.image, required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: myTextTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Image.network(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
                text: name,
                style: myTextTheme.labelMedium?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
                children: [
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(
                      width: 4,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: myTextTheme.labelSmall?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(
                      width: 4,
                    ),
                  ),
                ]),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}