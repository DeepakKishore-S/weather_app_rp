import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_news_app/model/data_model/weather_state.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';
import 'package:weather_news_app/res/utils.dart';
import 'package:weather_news_app/view/common/network_image_widget.dart';

class AppBarWidget extends StatelessWidget {
  final bool isCollapsed;
  final WeatherState weatherState;

  const AppBarWidget({
    super.key,
    required this.isCollapsed,
    required this.weatherState,
  });

  @override
  Widget build(BuildContext context) {
    final weatherData = weatherState.weatherData!.list[0];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isCollapsed
          ? const Color.fromARGB(255, 39, 78, 98)
          : Colors.transparent,
      height: context.resources.screenHeight * 0.12,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: SafeArea(
          child: isCollapsed
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weatherData.weather[0].main,
                            style: GoogleFonts.roboto(
                              fontSize: context.resources.dimension.mediumText,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(weatherState.weatherData!.city.name ,
                                  style: GoogleFonts.roboto(
                                    fontSize:
                                        context.resources.dimension.mediumText,
                                    color: Colors.white,
                                  )),
                              Text("  ${weatherData.main.temp.ceil()}°",
                                  style: GoogleFonts.roboto(
                                    fontSize:
                                        context.resources.dimension.mediumText,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: WeatherNetworkImageWidget(
                          imageUrl:
                              AppUtils.weatherUrl(weatherData.weather[0].icon),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.settings,
                          color:
                              isCollapsed ? Colors.white : Colors.transparent),
                    ],
                  ),
                )
              : const SizedBox.shrink()),
    );
  }
}
