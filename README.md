# Weather and News Aggregator App

## Overview

The Weather and News Aggregator App fetches and displays weather information and news headlines based on the user's location. It filters news articles according to current weather conditions, providing a tailored news experience.

## Features

- **Weather Information**: Fetches current weather data, including temperature and conditions, and displays a five-day forecast.
- **News Headlines**: Retrieves and displays the latest news headlines with brief descriptions and links to full articles.
- **Weather-Based News Filtering**: Filters news based on weather conditions:
  - Cold weather: Shows news related to general or depressing topics.
  - Hot weather: Displays news related to fear or crime.
  - Cool weather: Highlights positive news such as sports and achievements.
- **Settings**: Allows users to choose temperature units (Celsius/Fahrenheit) and select preferred news categories.

## Tech Stack

- **Flutter**: Framework for building the app.
- **Dart**: Programming language used for development.
- **Riverpod**: State management solution.
- **OpenWeatherMap API**: Provides weather data.
- **NewsAPI**: Provides news headlines.
- **SharedPreferences**: For persisting user preferences.

## Project Structure

- **models/**: Contains state and data models.
- **repositories/**: Manages data operations and abstracts data sources.
- **viewmodels/**: Contains logic for interacting with data and business rules.
- **views/**: Includes UI components like screens.
- **services/**: Handles data fetching from APIs.
- **providers/**: Defines Riverpod providers for dependency injection.

