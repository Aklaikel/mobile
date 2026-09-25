import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise 02 - Calculator',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  static const List<String> buttons = [
    '7',
    '8',
    '9',
    'C',
    'AC',
    '4',
    '5',
    '6',
    '+',
    '-',
    '1',
    '2',
    '3',
    '×',
    '/',
    '0',
    '.',
    '00',
    '=',
  ];

  void _onButtonPressed(String label) {
    // Print to debug console when any button is pressed
    debugPrint('button pressed :$label');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 500;
          final contentWidth = isNarrow ? constraints.maxWidth : 480.0;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Display area
                  Container(
                    height: isNarrow ? 180 : 220,
                    width: double.infinity,
                    color: Colors.blueGrey.shade800,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white38, fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  // Buttons grid
                  Container(
                    color: Colors.blueGrey.shade300,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: isNarrow ? 2.5 : 3.5,
                      children:
                          buttons.map((label) {
                            final isSpecial =
                                (label == 'C' ||
                                    label == 'AC' ||
                                    label == '=' ||
                                    label == '00' ||
                                    label == '.');
                            return _CalcButton(
                              label: label,
                              onPressed: () => _onButtonPressed(label),
                              color:
                                  isSpecial
                                      ? Colors.redAccent.shade100
                                      : Colors.transparent,
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const _CalcButton({
    required this.label,
    required this.onPressed,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool emphasize = color != null;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: emphasize ? color : Colors.blueGrey.shade200,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
