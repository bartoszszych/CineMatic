# CineMatic

CineMatic is a learning project iOS app that allows users to view top-rated movies. The app utilizes the free TMDB API to fetch movie data and presents it in a table view. When a user selects a movie, they can access additional details about the film, including its score, overview, and number of votes.

## Technologies

CineMatic is built using the following technologies:

- Swift: The programming language used to develop the app.
- UIKit: The framework used to develop the app.
- MVVM: The architectural pattern used to develop the app.
- CocoaPods: The dependency manager used to install and manage third-party libraries.

## Features

With CineMatic, users can:

- View top-rated movies.
- Access additional details about a movie including its score, overview, and number of votes.
- Search for movies by title.
- Load more movies as they scroll down the table view.

## Installation

To run CineMatic on your device, follow these steps:

1. Clone the repository to your local machine.
2. Install CocoaPods by running the following command in the terminal:

```
sudo gem install cocoapods
```

3. Navigate to the project directory in the terminal and run the following command to install the required dependencies:

```
pod install
```

4. Open the project in Xcode using the newly created `.xcworkspace` file.
5. In the `Supporting` folder, open the `Constants.swift` file and replace the value of `API_KEY` with your own [API key](https://developers.themoviedb.org/3/getting-started/introduction). 

```swift
struct Constants {
    ...
    static let API_KEY = "YOUR API KEY"
}
```
6. Build and run the project on a simulator or a physical device.

## Credits

CineMatic was developed with the help of [HackingWithSwift.com](https://www.hackingwithswift.com/) 
and the [Codebrah YouTube channel](https://www.youtube.com/@Codebrah). 
The app utilizes the [TMDB API](https://developers.themoviedb.org/3/getting-started/introduction) to fetch movie data.
