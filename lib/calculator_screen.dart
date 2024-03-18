import 'dart:math';

import 'package:flutter/material.dart';
import 'package:calculator/components/calc_button.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = "0";
  String equation = "";
  String expression = "";
  bool isOperator = false;
  int fontSizeLong = 20;

  String doesContainDecimal(dynamic text) {
    List<String> part = text.toString().split('.');
    if (!(int.parse(part[1]) > 0)) {
      return part[0];
    }
    return text;
  }

  getResult() {
    expression = equation;
    expression = expression.replaceAll("÷", "/");
    expression = expression.replaceAll("x", "*");
    expression = expression.replaceAll('%', '%');
    if (int.tryParse(expression[expression.length - 1]) == null) {
      expression = expression.substring(0, expression.length - 1);
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      result = "${exp.evaluate(EvaluationType.REAL, cm)}";
      result = doesContainDecimal(result);
      equation = result;
      isOperator = true;
    } catch (e) {
      result = "Error";
      equation = "";
    }
  }

  buttonPressed(String text) {
    setState(() {
      if (text == "AC") {
        result = "0";
        equation = "";
      } else if (text == "=") {
        equation += result;
        getResult();
      } else if (int.tryParse(text) != null) {
        result = (result == "0" || isOperator) ? text : result + text;
        isOperator = false;
      } else if (text == "%") {
        int? prev = int.tryParse(equation.substring(0, equation.length - 1));
        if (prev != null) {
          result = (prev * int.parse(result) / 100).toString();
        }
      } else if (text == ".") {
        result += !result.contains('.') ? text : '';
      } else {
        if (isOperator) {
          equation =
              equation.replaceRange(equation.length - 1, equation.length, text);
        } else {
          equation += result;
          print(equation);
          if (int.tryParse(equation[equation.length - 1]) != null) {
            getResult();
          }
          equation += text;
          isOperator = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 18),
            child: Text(
              "DEG",
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    result,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  color: Colors.orange,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      equation,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () => buttonPressed('⌫'),
                //   icon: const Icon(
                //     Icons.backspace_outlined,
                //     color: Colors.orange,
                //   ),
                // ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton(
                  buttonText: "AC",
                  buttonColor: Colors.black38,
                  titleStyle: Theme.of(context).textTheme.titleSmall,
                  buttonPressed: () => buttonPressed("AC"),
                ),
                CalcButton(
                  buttonText: "%",
                  buttonColor: Colors.black38,
                  buttonPressed: () => buttonPressed("%"),
                ),
                CalcButton(
                  buttonText: "÷",
                  buttonColor: Colors.black38,
                  buttonPressed: () => buttonPressed('÷'),
                ),
                CalcButton(
                  buttonText: "x",
                  buttonColor: Colors.black38,
                  buttonPressed: () => buttonPressed('x'),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton(
                  buttonText: '7',
                  buttonPressed: () => buttonPressed('7'),
                ),
                CalcButton(
                  buttonText: '8',
                  buttonPressed: () => buttonPressed('8'),
                ),
                CalcButton(
                  buttonText: '9',
                  buttonPressed: () => buttonPressed('9'),
                ),
                CalcButton(
                  buttonText: '-',
                  buttonColor: Colors.black38,
                  buttonPressed: () => buttonPressed('-'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalcButton(
                  buttonText: '4',
                  buttonPressed: () => buttonPressed('4'),
                ),
                CalcButton(
                  buttonText: '5',
                  buttonPressed: () => buttonPressed('5'),
                ),
                CalcButton(
                  buttonText: '6',
                  buttonPressed: () => buttonPressed('6'),
                ),
                CalcButton(
                  buttonText: '+',
                  buttonColor: Colors.black38,
                  buttonPressed: () => buttonPressed('+'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CalcButton(
                          buttonText: '1',
                          buttonPressed: () => buttonPressed('1'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CalcButton(
                          buttonText: '2',
                          buttonPressed: () => buttonPressed('2'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CalcButton(
                          buttonText: '3',
                          buttonPressed: () => buttonPressed('3'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CalcButton(
                          buttonText: '+/-',
                          titleStyle: Theme.of(context).textTheme.titleSmall,
                          buttonPressed: () => buttonPressed('+/-'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CalcButton(
                          buttonText: '0',
                          buttonPressed: () => buttonPressed('0'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        CalcButton(
                          buttonText: '.',
                          buttonPressed: () => buttonPressed('.'),
                        ),
                      ],
                    ),
                  ],
                ),
                CalcButton(
                  buttonText: '=',
                  buttonColor: Colors.orange,
                  buttonPressed: () => buttonPressed('='),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
