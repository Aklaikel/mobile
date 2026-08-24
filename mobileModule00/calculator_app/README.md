# Calculator App

This Flutter app is a small calculator UI for evaluating arithmetic expressions. It demonstrates basic widget composition, state management, and expression parsing with the `math_expressions` package.

## Features

- Displays the current expression and the latest result
- Supports numeric input and common arithmetic buttons
- Evaluates valid expressions as the user types when the expression is complete
- Uses `=` to finalize evaluation
- Includes `C` to remove the last character and `AC` to reset everything
- Formats integer results without a trailing `.0`
- Adapts its layout based on screen width for narrower and wider devices

## How to run

From the `calculator_app` directory:

1. Install the project dependencies:
   ```bash
   flutter pub get
   ```
2. Launch the app:
   ```bash
   flutter run
   ```

If you want to run it in a browser target (when supported by your environment), you can use:

```bash
flutter run -d chrome
```

## How the calculator works

The app stores the expression as a string and updates it as buttons are pressed. When the user types a valid expression, it is converted for the parser and evaluated using `math_expressions`.

A few implementation details matter:

- The visual multiplication symbol is `×`, but the code converts it to `*` before parsing.
- The app only evaluates while the input is complete; incomplete trailing operators are ignored during typing.
- If parsing fails or the result is invalid (`Infinity`, `NaN`, or malformed input), the app shows `Error` instead of crashing.

## Edge cases and handling

- Empty input
  - If the expression is empty, the display remains at `0`.

- Incomplete expressions while typing
  - If the expression ends with an operator (`+`, `-`, `*`, `/`), it is not evaluated until the user finishes the expression.
  - This prevents parser errors from transient intermediate states.

- Invalid final expression
  - Pressing `=` triggers a final evaluation pass.
  - If the expression cannot be parsed, the app shows `Error`.

- Division by zero / invalid math results
  - The code checks whether the evaluation result is infinite or not a number.
  - In those cases, it replaces the result with `Error`.

- Clearing input
  - `C` removes the last character from the expression.
  - `AC` clears the expression entirely and resets the display to `0`.

- Whole-number formatting
  - If the computed value is an integer, the app strips the `.0` suffix for cleaner output.

## Project files

- `lib/main.dart` – app logic and UI
- `pubspec.yaml` – Flutter dependencies, including `math_expressions`

## Notes

The calculator is intentionally lightweight and focused on correctness for basic arithmetic input and validation. It is a good example of using Flutter state, button-based input handling, and safe expression evaluation without exposing the app to parser crashes.
