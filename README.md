

![Your paragraph text](https://github.com/user-attachments/assets/5c31d36d-3952-4e9a-8789-155f7f19e44e)


<h1>🚗 Infinite Auto Carousel in Flutter</h1>
<h5>A smooth and infinite auto-scrolling carousel in Flutter that transitions seamlessly between items. The carousel displays car images and details, using a mock JSON file (mock_cars.json) as the data source.
</h5>

https://github.com/user-attachments/assets/3a962720-99db-4d38-9def-136fc25a3ebb


<br>
<h2>📌 Setup Instructions</h2>
<h3>Create the Required Folder and Move the File</h3>
<h5>
After cloning the repository, you need to manually create an assets folder in your Flutter project and move the mock_cars.json file inside it.
</h5><br>
Steps:
Navigate to your Flutter project directory.

Create an assets folder if it doesn't exist:

>your_flutter_project/<br>
┗── assets/<br>
    ┗── mock_cars.json  👈 Place the file here

Register the assets folder in pubspec.yaml:
```
flutter:
  assets:
    - assets/mock_cars.json

```
##Run:

`flutter pub get`
Now, the app will be able to read the mock_cars.json file correctly.

