Exercise 01 - Say Hello to the World

This folder contains a minimal Flutter application for Exercise 01.

Behavior:
- Displays a text and a button centered on the screen.
- When the button is pressed, the text toggles between the initial text ("Welcome") and "Hello World!".
- Each button press prints the currently displayed text to the debug console.
- Layout adapts to narrow screens.

How to run:
1. Ensure Flutter SDK is installed and on your PATH (or use an alias that invokes the SDK).
2. From this directory:
   flutter pub get
   flutter run

Files:
- lib/main.dart: main app (stateful) toggling the display text.
- pubspec.yaml: package manifest.
