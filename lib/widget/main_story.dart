
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
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
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
        SizedBox(
          height: 4.0,
        ),
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
        SizedBox(
          height: 4.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
                text: name,
                style: myTextTheme.labelMedium?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
                children: [
                  WidgetSpan(
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
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: SizedBox(
                      width: 4,
                    ),
                  ),
                  TextSpan(
                    text: "...See more",
                    style: myTextTheme.labelSmall?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ]),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}