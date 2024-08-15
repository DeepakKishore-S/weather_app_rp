import 'package:flutter/material.dart';
import 'package:weather_news_app/model/data_model/weather_state.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';
import 'package:weather_news_app/res/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_news_app/view/common/network_image_widget.dart';

class WeatherInfoWidget extends StatelessWidget {
  final WeatherState weatherState;
  final bool isCollapsed;

  const WeatherInfoWidget({
    super.key,
    required this.weatherState,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    final weatherData = weatherState.weatherData!.list[0];
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: AppUtils.getWeatherGradient(
          weatherDescription: weatherData.weather[0].main,
          weatherMain: weatherData.weather[0].description,
        ),
      ),
      child: Center(
          child: isCollapsed
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WeatherNetworkImageWidget(
                        imageUrl:
                            AppUtils.weatherUrl(weatherData.weather[0].icon),
                      ),
                      Text(
                        weatherState.weatherData!.city.name,
                        style: GoogleFonts.roboto(
                          fontSize: context.resources.dimension.smallText,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${weatherData.main.temp.ceil()}°',
                        style: GoogleFonts.roboto(
                          fontSize: context.resources.dimension.bigTitleText,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        weatherData.weather[0].main,
                        style: GoogleFonts.roboto(
                          fontSize: context.resources.dimension.smallText,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Max:${weatherData.main.temp_max.ceil()}° Min:${weatherState.weatherData!.list[0].main.temp_min.ceil()}°",
                        style: GoogleFonts.roboto(
                          fontSize: context.resources.dimension.verySmallText,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )),
    );
  }
}
