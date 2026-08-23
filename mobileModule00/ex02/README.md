Exercise 02 - Calculator UI

This project contains a simple, responsive calculator UI for Exercise 02.

Behavior:
- A display area (static for this exercise) and a 4x4 grid of buttons below.
- Pressing any button prints its label to the debug console with the format:
  button pressed :<label>

How to run:
1. Ensure your Flutter SDK is available (on PATH or via alias).
2. From this directory (mobileModule00/ex02) run:
   flutter pub get
   flutter run

Files:
- lib/main.dart: the app. Buttons print labels to the debug console.
- pubspec.yaml: package manifest.

Notes:
- The app is intentionally simple for the exercise: buttons only log their label — no calculation logic implemented.
- Layout adapts to narrow and wide screens using LayoutBuilder and constraints.
