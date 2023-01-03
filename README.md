# Flutter Top Repositories

This Flutter project allows users to fetch and display the top repositories from GitHub. The main page of the app includes a scroll button with the options to select the number of repositories to display (5, 10, or 15) and a "fetch" button. When the user selects a number and clicks the "fetch" button, the app will retrieve and display the selected number of top repositories in a list of card widgets, each containing the repository's name, URL, description, and number of stargazers.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [GitHub API Key](https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#registering-your-app)(optional, if you want to make more than 60 requests per hour) 

### Installing 

**1. Clone the repository:**

```
git clone https://github.com/[USERNAME]/flutter-top-repositories.git 
```

**2. Navigate to the project directory:**

```
cd flutter-top-repositories 
```

**3. Add your GitHub API key to the .env file (optional):**

```
GITHUB_API_KEY=[YOUR_API_KEY]
```

**4. Run the app:**

```
flutter run
```

## Built With
- [Flutter](https://flutter.dev/)(- A cross-platform mobile app development framework)
- [GitHub API](https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api)(- Used to retrieve data from GitHub)
- [http](https://pub.dev/packages/http)(- A library for making HTTP requests in Flutter)
- [dart:convert](https://api.dart.dev/stable/2.10.2/dart-convert/dart-convert-library.html)(- A library for decoding and encoding JSON in Dart)


For further help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Thank you...!

