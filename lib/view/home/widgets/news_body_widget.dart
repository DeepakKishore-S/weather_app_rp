import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/model/data_model/news_state.dart';

class NewsBodyWidget extends StatelessWidget {
  final NewsState newsState;

  const NewsBodyWidget({
    super.key,
    required this.newsState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (newsState.errorMessage != null)
          _buildErrorWidget(newsState.errorMessage!)
        else if (newsState.newsData != null)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newsState.newsData!.length,
            itemBuilder: (context, index) {
              final article = newsState.newsData![index];
              return ListTile(
                title: Text(article['title']),
                subtitle: Text(article['description'] ?? ''),
                onTap: () => _launchURL(article['url']),
              );
            },
          ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Error: $errorMessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
