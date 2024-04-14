import 'dart:core';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise 03',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _mathExpression = '0';
  num _result = 0;

  final List<String> _buttonLabels = [
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
    '*',
    '/',
    '0',
    '.',
    '00',
    '=',
    'EMPTY BOX'
  ];

  void _buttonAction(String msg) {
    String newExpression = _mathExpression;
    num newResult = _result;

    switch (msg) {
      case 'C':
        if (newExpression != '0') {
          newExpression = newExpression.substring(0, newExpression.length - 1);
        }
        break;
      case 'AC':
        newExpression = '0';
        newResult = 0;
        break;
      case '=':
        try {
          Parser p = Parser();
          Expression exp = p.parse(newExpression);
          newResult = exp.evaluate(EvaluationType.REAL, ContextModel());
        } catch (e) {
          newResult = 0;
          newExpression = '0';
        }
        break;
      case '0':
        if (newExpression != "0") {
          newExpression += msg;
        }
        break;
      case '00':
        if (['+', '-', '*', '/'].contains(newExpression[newExpression.length - 1])) {
          newExpression += '0';
        } else if (newExpression != '0') {
          newExpression += msg;
        }
        break;
      default:
        if (newExpression == '0') {
          newExpression = msg;
        } else {
          newExpression += msg;
        }
        break;
    }

    setState(() {
      _mathExpression = newExpression;
      _result = newResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // fit: StackFit.expand,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _mathExpression,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _result.toString(),
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  Row(
                    children: _buttonLabels
                        .sublist(0, 5)
                        .map((label) => Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _buttonAction(label);
                                },
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    children: _buttonLabels
                        .sublist(5, 10)
                        .map((label) => Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _buttonAction(label);
                                },
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                    children: _buttonLabels
                        .sublist(10, 15)
                        .map((label) => Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _buttonAction(label);
                                },
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Row(
                      children: _buttonLabels
                          .sublist(15, 20)
                          .map((label) => Expanded(
                                child: label == 'EMPTY BOX'
                                    ? const SizedBox(
                                        width: 0,
                                        height: 0,
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          _buttonAction(label);
                                        },
                                        child: Text(
                                          label,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                              ))
                          .toList()),
                ],
              ))
        ],
      ),
    );
  }
}
