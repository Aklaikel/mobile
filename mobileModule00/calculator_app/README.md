Calculator App (Exercise 03 - It's Alive!)

This Flutter app implements a working calculator as required by Exercise 03.

Features
- Displays the current expression and a computed result.
- Supports addition, subtraction, multiplication, and division.
- Supports multiple operations in one expression (operator precedence applied).
- Allows entering negative numbers by pressing '-' before the number.
- Allows decimal numbers and the '00' shortcut.
- Delete last character (C) and clear everything (AC).
- '=' evaluates the expression; live result updates as the expression is typed (when parseable).
- The UI is responsive and adapts to narrow and wide screens.

How to run
1. Ensure Flutter SDK is installed and available on PATH (or use alias).
2. From the project directory (mobileModule00/calculator_app):
   flutter pub get
   flutter run

Notes and edge case handling
- The app uses the math_expressions package to parse and evaluate expressions. Multiplication symbol '×' is converted to '*' for parsing.
- If evaluation produces Infinity or NaN (e.g., division by zero), the app shows 'Error' in the result area and does not crash.
- Parsing or evaluation errors (e.g., malformed expression) are caught; during typing an incomplete expression is not evaluated until it's parseable, and pressing '=' shows 'Error' if evaluation fails.
- The UI intentionally separates controls (AC, =) and the numeric/operator grid for clarity.

Files
- lib/main.dart: main application and logic
- pubspec.yaml: includes math_expressions dependency

If you'd like further improvements (history, parentheses, better formatting of results), tell me which feature to add next.
