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

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0.0 or later)
- Dart SDK (version 2.18.0 or later)

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/weather-news-aggregator.git
    cd weather-news-aggregator
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Add your API keys:
   - Replace `YOUR_OPENWEATHERMAP_API_KEY` in `services/weather_service.dart`.
   - Replace `YOUR_NEWSAPI_KEY` in `services/news_service.dart`.

4. Run the app:
    ```bash
    flutter run
    ```

### Usage

1. **Home Screen**: Displays current weather and news headlines. Refresh the data by tapping the floating action button.
2. **Settings Screen**: Access via the app’s navigation menu. Allows you to set temperature units and select news categories.

### Configuration

- **Weather Units**: Change temperature units between Celsius and Fahrenheit in the Settings screen.
- **News Categories**: Customize news categories based on your interests in the Settings screen.

## Development

### Running Tests

To run tests, use the following command:
```bash
flutter test


