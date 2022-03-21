import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.error(messageText: 'This is a error text')
                    .show(context);
              },
              child: const Text("Error"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.info(messageText: 'This is a info text')
                    .show(context);
              },
              child: const Text("Info"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.warning(messageText: 'This is a warning text')
                    .show(context);
              },
              child: const Text("Warning"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.success(messageText: 'This is a success text')
                    .show(context);
              },
              child: const Text("Success"),
            ),
          ],
        ),
      ),
    );
  }
}
