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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text('Material UI'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material('This a snackbar with info type',
                          type: AnimatedSnackBarType.info,
                          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          desktopSnackBarPosition:
                              DesktopSnackBarPosition.bottomLeft)
                      .show(context);
                },
                child: const Text("Info"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material(
                    'This a snackbar with info type and a very very very long text',
                    type: AnimatedSnackBarType.info,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    desktopSnackBarPosition: DesktopSnackBarPosition.bottomLeft,
                    snackBarStrategy: RemoveSnackBarStrategy(),
                  ).show(context);
                },
                child: const Text("Long Info"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material(
                    'This a snackbar with error type',
                    type: AnimatedSnackBarType.error,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
                  ).show(context);
                },
                child: const Text("Error"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material(
                    'This a snackbar with success type',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                  ).show(context);
                },
                child: const Text("Success"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material(
                    'This a snackbar with warning type',
                    type: AnimatedSnackBarType.warning,
                  ).show(context);
                },
                child: const Text("Warning"),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              const Text('Colorized Rectangle'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Info',
                    'This is an info snack bar',
                    type: AnimatedSnackBarType.info,
                    brightness: Brightness.light,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Info"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Error',
                    'This is an error snack bar',
                    type: AnimatedSnackBarType.error,
                    brightness: Brightness.light,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Error"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Success',
                    'This is a success snack bar',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.light,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Success"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Warning',
                    'This is a warning snack bar',
                    type: AnimatedSnackBarType.warning,
                    brightness: Brightness.light,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Warning"),
              ),
              const SizedBox(height: 10),
              const Text('Dark Rectangle'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Info',
                    'This is an info snack bar',
                    type: AnimatedSnackBarType.info,
                    brightness: Brightness.dark,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Info"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Error',
                    'This is an error snack bar',
                    type: AnimatedSnackBarType.error,
                    brightness: Brightness.dark,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Error"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Success',
                    'This is a success snack bar',
                    type: AnimatedSnackBarType.success,
                    brightness: Brightness.dark,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Success"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  AnimatedSnackBar.rectangle(
                    'Warning',
                    'This is a warning snack bar',
                    type: AnimatedSnackBarType.warning,
                    brightness: Brightness.dark,
                  ).show(
                    context,
                  );
                }),
                child: const Text("Warning"),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
