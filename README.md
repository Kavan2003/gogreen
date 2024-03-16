# GoGreen Flutter App

## Project Overview

GoGreen Flutter App is a comprehensive application aimed at promoting environmental awareness and sustainability. It integrates live Air Quality Index (AQI) data, plant suggestions for planting, and location-based AQI search functionality to empower users to make informed decisions about their environmental impact.

### Key Features and Functionalities

- **Live AQI Display:** View real-time Air Quality Index (AQI) data for your location and other selected areas.
- **Plant Suggestions:** Receive personalized plant suggestions based on your location and environmental conditions, powered by Gemini API.
- **Location-based AQI Search:** Search for AQI data in specific locations to make informed decisions about outdoor activities and health precautions.

## Installation and Setup

To use GoGreen Flutter App, ensure you have Flutter installed and add the necessary dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_email_validator: ^2.0.1

  cupertino_icons: ^1.0.6
  flutter_local_notifications: ^17.0.0
  permission_handler: ^11.3.0
  maplibre_gl:
    git:
      url: https://github.com/maplibre/flutter-maplibre-gl.git
      ref: main
  form_validator: ^2.1.1
  flutter_gemini: ^2.0.3
  image_picker: ^1.0.7
  autocomplete_textfield: ^2.0.1
```

## Run the following command to install the dependencies:

```
flutter pub get
```

## No special configurations are required; simply run the Flutter app on your local machine.

## Currently Implemented Features

- **Live AQI Display:** Fetch and display live Air Quality Index (AQI) data from API.
- **Location-based AQI Search:** Search for AQI data in specific locations using location-based AQI API.

## Future Development
- **Plant Suggestions:**  Enhance plant suggestion feature with more advanced algorithms and user customization options.
- **Advanced Data:** personalized air pollution data even for small area all over the country.

## Troubleshooting

#### If you encounter any issues or have suggestions for improvement, please feel free to create an issue or connect with us on LinkedIn.
#### With GoGreen Flutter App, we aim to empower users to make environmentally conscious decisions and contribute to a sustainable future.

