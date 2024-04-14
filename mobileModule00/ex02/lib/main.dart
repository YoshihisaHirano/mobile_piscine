import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise 02',
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
  String _printMsg = '';
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

  void _setPrintMsg(String msg) {
    setState(() {
      _printMsg = msg;
      print(_printMsg);
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
          const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '0',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.only(bottom: 32), child: Column(
            children: [
              Row(
                children: _buttonLabels
                    .sublist(0, 5)
                    .map((label) => Expanded(
                          child: TextButton(
                            onPressed: () {
                              _setPrintMsg(label);
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
                              _setPrintMsg(label);
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
                              _setPrintMsg(label);
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
                      .sublist(15,20)
                      .map((label) => Expanded(
                            child: label == 'EMPTY BOX'
                                ? const SizedBox(
                                    width: 0,
                                    height: 0,
                                  )
                                : TextButton(
                                    onPressed: () {
                                      _setPrintMsg(label);
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
