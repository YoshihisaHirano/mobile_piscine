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
      title: 'Exercise 01',
      theme: ThemeData.light(),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(isPressed ? "Hello world!" : "A simple text",
                    style: const TextStyle(
                        fontSize: 24,
                        decoration: TextDecoration.none,
                        color: Colors.white))),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
                child: const Text("Click me"))
          ],
        ));
  }
}
