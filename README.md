# Exercise Timer App

This is a Flutter mobile app that helps users track their exercises with a timer.

## Features

- **Home Screen**: Displays a list of exercises.
- **Exercise Details**: Tap on any exercise to view its details.
- **Start Exercise**: Tap the "Start Exercise" button to begin a countdown timer.
- **Completion Notification**: When the timer ends, the app notifies the user that the exercise is completed.
- **Progress Tracking**: After completion, the app navigates back to the exercise list and marks the exercise as completed.

Simple and useful for timed workouts!

## Architecture

The app is built using **BLoC** state management and follows the **MVVM** (Model-View-ViewModel) architecture pattern.

- **BLoC (Business Logic Component)** helps separate the presentation layer from business logic, making the app easier to manage, test, and scale.
- **MVVM** divides the app into Model, View, and ViewModel layers, which helps keep UI and business logic separate for better code organization and maintainability.

## Known Limitations

- The app currently has basic error handling. For example, if an error occurs while loading exercise data or starting the timer, the user may not see a detailed error message. Improving user feedback and error recovery is planned in future updates.

## How to Run

We have provided an `.apk` file for easy installation.

1. **Install the APK**
    - Transfer the `.apk` file to your Android device.
    - Tap on the file and follow the prompts to install it. (You may need to allow installation from unknown sources in your device settings.)

2. **Use the App**
    - Open the app after installation.
    - Follow the app flow as described above:
        - View the exercise list.
        - Tap an exercise to see details.
        - Tap "Start Exercise" to begin the timer.
        - On completion, you'll get a notification and return to the exercise list with progress marked.

> No development setup is needed if you are installing the provided APK.
