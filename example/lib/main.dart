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
      title: 'Animated Snack Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated Snack Bar'),
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
                AnimatedSnackBar.material(
                  'This a snackbar with info type',
                  type: AnimatedSnackBarType.info,
                ).show(context);
              },
              child: const Text("Info"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.material(
                  'This a snackbar with error type',
                  type: AnimatedSnackBarType.error,
                ).show(context);
              },
              child: const Text("Error"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.material(
                  'This a snackbar with success type',
                  type: AnimatedSnackBarType.success,
                ).show(context);
              },
              child: const Text("Success"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar.material(
                  'This a snackbar with warning type',
                  type: AnimatedSnackBarType.warning,
                ).show(context);
              },
              child: const Text("Warning"),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedSnackBar(
                  builder: ((context) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.amber,
                      height: 50,
                      child: const Text('A custom snackbar'),
                    );
                  }),
                ).show(context);
              },
              child: const Text("Custom"),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     AnimatedSnackBar.info(messageText: 'This is a info text')
            //         .show(context);
            //   },
            //   child: const Text("Info"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     AnimatedSnackBar.warning(messageText: 'This is a warning text')
            //         .show(context);
            //   },
            //   child: const Text("Warning"),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     AnimatedSnackBar.success(messageText: 'This is a success text')
            //         .show(context);
            //   },
            //   child: const Text("Success"),
            // ),
          ],
        ),
      ),
    );
  }
}
