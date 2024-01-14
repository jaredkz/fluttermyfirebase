# Flutter My Firebase
- First release: 12th Jan 2024
#### Current release: FMF V1.0.1 Jan 14 2024 preliminary release

## Global goal: 

Create a simple modular, up-to-date template with authentication and data persistence supported on web, android and (probably) iOS.

## About this project

In the spirit of the open source community and providing a solid basis for both learning and development, I have begun the endeavor to create a solid structure for a modular app that skips a lot of the early setup steps and allows you to jump right into the process of developing your brand new app.  
-
As I am in the process of learning flutter/dart, there may be errors or broken implementation or incorrect/inaccurate documentation that I am unaware of. I make my best effort to document things clearly so you know exactly what is going on, however any suggestions or expertise will be very welcome! =) 
- 

As the focus in this project is on modularity, this allows for separation of business logic and UI elements, easy customisation of various global shared components like GlobalSnackbar, UiHelpers, TextField and CustomErrorWidget.

### Features 
- Data persistence across web, android and iOS with firestore 
- A clear modular file structure
- Internationalization for changing languages (todo) 
- Generic naming schemes to allow for quick renaming and customization. 

### Under the hood
 - Flutter_modular 6.3.2 (for routing)
 - Navigator 2.0 (Flutter)
 - firebase_core: 2.24.2 / firebase_auth: 4.16.0 / cloud_firestore: 4.14.0

 #### Android 
 - Gradle 8.1.1
 - Kotlin 1.9.22 
 - Google Services 4.4.0


 The point of this project is to create a rock-solid foundation with firebase integration and error handling ready to go. Only tested on Web and Android.


The current stage of this project is as follows:

### Functionality:
- Authentication - YES (in preliminary release)
    - Modular disposal of the AuthModule once authentication has succeeded - YES
    - Login page, register page, forgot password page; all functional (only basic UI at this stage.)
    - Authentication persistence on module switch from Auth (module disposed on successful login) to the Home module.
    - Global error handling and display through GlobalSnackbar and CustomErrorWidget snackbar display.
    - Validation using a global version of Validatorless to ensure sanitised input and catch potential problems before form submission.
    

### Changelog
FMF v1.0.1
- Improved error reporting to show snackbar with a specific error message when possible.
- Added validatorless globally for email, password (min 6, max 30), and isSamePassword for confirmation.
- Added DevicePreview for debug mode to simulate what the app would look like across various platforms.
- Various code improvements/linting.

FMF v1.0.0 INITIAL BUILD
Firebase authentication working.

### Installation instructions:
0. Open this project in your console/command line and run flutter pub get
1. Make sure Firestore is installed.
2. Go to your firebase console (https://console.firebase.google.com/) and create a new project.
3. Type firebase login into your command prompt/terminal in this project.
Make sure it's logged in with the same email as your firebase console. 
Make sure the CLI is activated by typing:
dart pub global activate flutterfire_cli
Then finally type the following command to pick your project:
flutterfire configure
4. In your firebase console, go to authentication and enable the email provider.
5. In your firebase console, go to firestore database and create a new database. Make sure to go to the rules and change the 'write' rule from 'false' to 'true'

That's it! Enjoy!
