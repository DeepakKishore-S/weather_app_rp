import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_news_app/provider/location_provider.dart';
import 'package:weather_news_app/provider/settings_provider.dart';
import 'package:weather_news_app/res/AppContextExtension.dart';
import 'package:weather_news_app/view/home/home_screen.dart';

class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final units = ref.read(settingsViewModelProvider.notifier);
      units.loadUnit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationViewModelProvider);
    return Scaffold(
      body: locationState.when(
        data: (position) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, HomeScreen.route);
          });
          return null;
        },
        loading: () => Center(
            child: Lottie.asset(
          "assets/lottie/loader.json",
          height: 100,
          errorBuilder: (context, error, stackTrace) =>
              const CircularProgressIndicator(),
        )),
        error: (error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Lottie.asset(
                    "assets/lottie/location_permission.json",
                    height: 250,
                    errorBuilder: (context, error, stackTrace) =>
                        const CircularProgressIndicator(),
                  )),
                  Text(
                    error.toString().split(":")[1],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: context.resources.dimension.mediumText,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(locationViewModelProvider.notifier)
                          .checkLocationPermission();
                      ref
                          .read(locationViewModelProvider.notifier)
                          .openLocationSettings();
                    },
                    child: Text(error.toString().contains("permanently")
                        ? "Open Location Settings"
                        : 'Allow Permission'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
