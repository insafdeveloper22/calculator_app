import 'package:calculator_app/Screens/conponents/calculator_buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userInput = '';
  var answer = '';

void clear() {
    setState(() {
      userInput = '';
      answer = '';
    });
  }

  void deleteLast() {
    if (userInput.isNotEmpty) {
      setState(() {
        userInput = userInput.substring(0, userInput.length - 1);
      });
    }
  }

  void evaluateResult() {
    calculate();
    setState(() {});
  }

  void calculate() {
    try {
      String finaluserinput = userInput;
      finaluserinput = finaluserinput.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = "Error";
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Display Screen Area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      userInput.isEmpty ? '0' : userInput,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 32, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer.isEmpty ? '0' : answer,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Keypad Buttons Area
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Row 1: AC, +/-, %, ÷
                  Row(
                    children: [
                      btn(
                        "⌫",
                        onTap: deleteLast,
                        color: const Color(0xFFA5A5A5),
                        textColor: Colors.white,
                      ),
                      btn(
                        "AC",
                        color: const Color(0xFFA5A5A5),
                        textColor: Colors.white,
                        onTap: clear,
                      ),

                      btn(
                        "%",
                        color: const Color(0xFFA5A5A5),
                        textColor: Colors.white,
                      ),
                      btn("/", color: Colors.orange),
                    ],
                  ),

                  // Row 2: 7, 8, 9, x
                  Row(
                    children: [
                      btn("7"),
                      btn("8"),
                      btn("9"),
                      btn("x", color: Colors.orange),
                    ],
                  ),

                  // Row 3: 4, 5, 6, -
                  Row(
                    children: [
                      btn("4"),
                      btn("5"),
                      btn("6"),
                      btn("-", color: Colors.orange),
                    ],
                  ),

                  // Row 4: 1, 2, 3, +
                  Row(
                    children: [
                      btn("1"),
                      btn("2"),
                      btn("3"),
                      btn("+", color: Colors.orange),
                    ],
                  ),

                  // Row 5: 0, ., ⌫, =
                  Row(
                    children: [
                      btn("+/-"),
                      btn("0"),
                      btn("."),
                      btn("=", color: Colors.orange, onTap: evaluateResult),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  

  Widget btn(
    String text, {
    Color? color,
    Color textColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return CalculatorButtons(
      buttonText: text,
      buttonColor: color ?? const Color(0xFF333333),
      textColor: textColor,
      onPressed:
          onTap ??
          () {
            setState(() {
              userInput += text;
            });
          },
    );
  }
}
