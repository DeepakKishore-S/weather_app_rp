import 'package:flutter/material.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';

class WeatherNetworkImageWidget extends StatelessWidget {
  final String imageUrl;

  const WeatherNetworkImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return  Center(
          child: Icon(
            Icons.cloud_off, 
            color: Colors.white,
            size: context.resources.dimension.iconLargeSize,
          ),
        );
      },
    );
  }
}
