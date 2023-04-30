# Pokemon Quiz App

A boilerplate project created in flutter using MobX and Provider. Boilerplate supports both web and mobile, clone the appropriate branches mentioned below:


## Getting Started

The Boilerplate contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build 
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Pokemon App Features:

* Splash screen
* Home 
* Auto Routing
* Custom Theme
* Firebase Firestore Database & Storage
* Internet conncetion status
* Inputs Validation

### Up-Coming Features:


## Libraries & Tools Used

* [Firebase Firestore](https://pub.dev/packages/cloud_firestore)
* [Firebase Storage](https://pub.dev/packages/firebase_storage)
* [Equatable](https://pub.dev/packages/equatable) 
* [Bloc](https://pub.dev/packages/flutter_bloc) 
* [Routing](https://pub.dev/packages/auto_route)
* [Splash Screen](https://pub.dev/packages/flutter_native_splash)
* [Connectivity](https://pub.dev/packages/connectivity_plus)
* [System Ui](https://pub.dev/packages/flutter_keyboard_visibility)

## Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- common_widgets/
|- constants/
|- exceptions/
|- features/
|- routes/
|- utils/
|- main.dart
|- app.dart
|- app_bloc_observer.dart
|- firebase_options.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- common_widgets - All the widget used across multiple application's features.
2- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `enums` and `colors`.
3- exceptions - Contains all the custom exceptions created to manage various errors in the application.
4- features — Contains all the application's features.
5- routes — Contains the routing system's files.
6- utils — Contains common utilities functions used across the application.
```

### Features

This directory contains all the application features. A separate folder is created for each application features as shown in example below:

```
features/
|- about/
|- connectivity/
|- database/
|- home/
|- leaderboard/
|- quizz/
|- storage/
```

Each feature's folder structure may vary according to the purpose of the feature itself and its requirements. Here below an example of a feature's folder structure

```
quizz/
|- bloc/
|- components/
|- models/
|- view/
```

## Testing

Unit test coverage:
|                     | coverage |
|---------------------|----------|
| database service    | done     |
| database repository | done     |
| storage service     | done     |
| storage repository  | done     |

## Wiki

Checkout [wiki](https://github.com/zubairehman/flutter-boilerplate-project/wiki) for more info

## Conclusion
