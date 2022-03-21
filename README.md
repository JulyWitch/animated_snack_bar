# AnimatedSnackBar

A Flutter package to show beautiful animated snackbars directly using overlay.

## Features

- Material-UI snack bars

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/gifs/material.gif?raw=true)


## Getting started

Import the package 

```dart
import 'package:animated_snack_bar/animated_snack_bar.dart';
```

## Usage

Show material ui snackbar

```dart
AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.info,
).show(context);
```

Show a custom snackbar

```dart
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
```
