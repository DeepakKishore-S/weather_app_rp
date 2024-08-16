import 'package:flutter/material.dart';
import 'package:weather_news_app/model/data_model/weather/weather_data.dart';
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
      height: context.resources.screenHeight * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppUtils.getWeatherGradient(
          weatherDescription: weatherData.weather[0].description,
          weatherMain: weatherData.weather[0].main,
        ),
      ),
      child: Center(
          child: isCollapsed
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WeatherNetworkImageWidget(
                        imageUrl:
                            AppUtils.weatherUrl(weatherData.weather[0].icon),
                      ),
                      Text(
                        weatherState.weatherData!.city.name,
                        style: GoogleFonts.roboto(
                          fontSize: context.resources.dimension.mediumText,
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
                          fontSize: context.resources.dimension.mediumText,
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
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final List<WeatherInfo> weatherDatum =
                                AppUtils.getUniqueEntriesByDate(
                                    weatherState.weatherData!.list);
                            final WeatherInfo data = weatherDatum[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 130,
                              width: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data.main.temp.ceil()}°",
                                    style: GoogleFonts.roboto(
                                      fontSize: context
                                          .resources.dimension.verySmallText,
                                      color: Colors.black,
                                    ),
                                  ),
                                  WeatherNetworkImageWidget(
                                    imageUrl: AppUtils.weatherUrl(
                                        data.weather[0].icon),
                                  ),
                                  Text(
                                      index == 0
                                          ? "Today"
                                          : AppUtils.getDayAbbreviation(
                                              data.dt_txt),
                                      style: GoogleFonts.roboto(
                                        fontSize: context
                                            .resources.dimension.verySmallText,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
