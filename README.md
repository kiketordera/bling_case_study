# bling_case_study

## Features

The app includes the following features:
- **Name Input:** Allows the user to input a name.
- **Send Request:** Sends the name to the Agify.io API to get an age estimate.
- **Display Result:** Shows the estimated age in a bottom sheet.
- **Restart:** Allows the user to clear the input and reset the app to estimate another name.

## Getting Started


**Run the app:**
    ```bash
    flutter run
    ```

## Code Overview

### BLoC (Business Logic Component)

The BLoC pattern is used to manage the state of the application.

- **age_estimator_bloc.dart:** Defines the events, states, and the BLoC itself for managing the age estimation logic.

### Models

Defines the data structures used in the application.

- **age_estimate.dart:** Model class representing the age estimate response from the API.

### Repositories

Handles data operations and business logic.

- **age_repository.dart:** Interacts with the `AgeApiService` to fetch age estimates.

### Services

Contains services that handle API calls.

- **age_api_service.dart:** Service class that makes HTTP requests to the Agify.io API.

### Screens

Contains the UI components of the application.

- **age_estimator_screen.dart:** Main screen where the user can input a name and view the result.

### Widgets

Contains reusable UI components.

- **bottom_sheet.dart:** Widget for displaying the age estimate result in a bottom sheet.

### Main

Entry point of the application.

- **main.dart:** Sets up and runs the Flutter app.

## Conclusion

This case study showcases a Flutter application that estimates age based on a given name using the Agify.io API. The project demonstrates the use of the BLoC architecture for state management, separation of concerns, and a clean, maintainable code structure.

Feel free to reach out if you have any questions or feedback. Thank you for your time!