🚗 Infinite Auto Carousel in Flutter
A smooth and infinite auto-scrolling carousel in Flutter that transitions seamlessly between items. The carousel displays car images and details, using a mock JSON file (mock_cars.json) as the data source.

📌 Setup Instructions

1️ Create the Required Folder and Move the File
After cloning the repository, you need to manually create an assets folder in your Flutter project and move the mock_cars.json file inside it.
----------------------------------------------------------------------------------------------
Steps:
Navigate to your Flutter project directory.

Create an assets folder if it doesn't exist:

your_flutter_project/
┗── assets/
    ┗── mock_cars.json  👈 Place the file here

 --------------------------------------------------------------------------------------------   
Register the assets folder in pubspec.yaml:

flutter:
  assets:
    - assets/mock_cars.json

-------------------------------------------------------------------------------------------
Run:
flutter pub get
Now, the app will be able to read the mock_cars.json file correctly.


 
