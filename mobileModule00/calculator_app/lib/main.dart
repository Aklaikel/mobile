import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '0';

  static const List<String> _buttons = [
    '7', '8', '9', 'C',
    '4', '5', '6', '+',
    '1', '2', '3', '×',
    '0', '.', '00', '/',
  ];

  void _onButtonPressed(String label) {
    setState(() {
      if (label == 'C') {
        // delete last character
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (label == 'AC') {
        // clear everything
        _expression = '';
        _result = '0';
      } else if (label == '=') {
        _evaluateExpression(finalEvaluation: true);
      } else {
        // Append label (allow negative numbers by pressing '-' first)
        // Map the multiplication symbol to internal '×' as visual; evaluation will convert
        _expression += label;
        // Try to update result live
        _evaluateExpression();
      }
    });
    debugPrint('button pressed :$label');
  }

  void _evaluateExpression({bool finalEvaluation = false}) {
    // prepare expression for parser
    String exp = _expression.replaceAll('×', '*');

    // If expression is empty or ends with an operator, skip evaluation unless finalEvaluation is true
    if (exp.isEmpty) {
      _result = '0';
      return;
    }

    // Do not evaluate if trailing char is an operator (except when finalEvaluation is true and it's a unary minus at start)
    final trailing = exp.substring(exp.length - 1);
    final operators = ['+', '-', '*', '/'];
    if (!finalEvaluation && operators.contains(trailing)) {
      // don't attempt to parse incomplete expression
      return;
    }

    try {
      Parser p = Parser();
      Expression parsed = p.parse(exp);
      ContextModel cm = ContextModel();
      double eval = parsed.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        _result = 'Error';
      } else {
        // Format result: remove trailing .0 when possible
        if (eval == eval.roundToDouble()) {
          _result = eval.toInt().toString();
        } else {
          _result = eval.toString();
        }
      }
    } catch (e) {
      // Parsing or evaluation error: if finalEvaluation show Error, otherwise ignore
      if (finalEvaluation) {
        _result = 'Error';
      }
    }
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
                  // display area
                  Container(
                    height: isNarrow ? 170 : 200,
                    width: double.infinity,
                    color: Colors.blueGrey.shade800,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child: Text(
                            _expression.isEmpty ? '0' : _expression,
                            style: TextStyle(color: Colors.white70, fontSize: 18),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _result,
                          style: TextStyle(color: Colors.white38, fontSize: 22),
                        ),
                      ],
                    ),
                  ),

                  // Top control row: AC and =
                  Container(
                    color: Colors.blueGrey.shade300,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => _onButtonPressed('AC'),
                          child: const Text('AC', style: TextStyle(color: Colors.red)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => _onButtonPressed('='),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                            child: Text('=', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Buttons grid
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey.shade300,
                      child: GridView.count(
                        padding: const EdgeInsets.all(8.0),
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        childAspectRatio: isNarrow ? 2.2 : 3.5,
                        children: _buildButtons(),
                      ),
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

  List<Widget> _buildButtons() {
    return _buttons.map((label) {
      final isOperator = ['+', '-', '×', '/', '='].contains(label);
      final isControl = label == 'C';
      final color = isOperator ? Colors.blueGrey.shade100 : Colors.transparent;

      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isControl ? Colors.redAccent.shade100 : color,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          onPressed: () => _onButtonPressed(label),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
      );
    }).toList();
  }
}
