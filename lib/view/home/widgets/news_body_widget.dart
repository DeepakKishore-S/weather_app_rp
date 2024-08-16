import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/model/data_model/news_state.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';

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
        else if (newsState.newsData != null) ...[
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.newspaper_rounded),
              ),
              Text("News Headlines",
                  style: GoogleFonts.roboto(
                    fontSize: context.resources.dimension.bigText,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newsState.newsData!.articles!.length,
            itemBuilder: (context, index) {
              final article = newsState.newsData!.articles![index];
              return Card(
                elevation: 5,
                child: ListTile(
                  title: Text(article.title??"",
                      style: GoogleFonts.roboto(
                        fontSize: context.resources.dimension.mediumText,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  subtitle: Text(article.description ?? '',
                      style: GoogleFonts.roboto(
                        fontSize: context.resources.dimension.smallText,
                        color: Colors.black,
                      )),
                  onTap: () => _launchURL(article.url??""),
                ),
              );
            },
          ),
        ]
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
