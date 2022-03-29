# AnimatedSnackBar

A Flutter package to show beautiful animated snackbars directly using overlay.

## Features

- Material-UI

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material.gif?raw=true)

<img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material-error.png" height="600">  

- Colorized rectangle


<img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-error.png" height="600">  

- Dark rectangle

<img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/dark-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/dark-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/dark-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/blob/master/files/dark-error.png" height="600">

## Getting started

Import the package 

```dart
import 'package:animated_snack_bar/animated_snack_bar.dart';
```

## Usage

* Show material ui snackbar

```dart
AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.info,
).show(context);
```

* Show colorized rectangle snackbar

```dart
AnimatedSnackBar.rectangle(
'Success',
  'This is a success snack bar',
  type: AnimatedSnackBarType.success,
  brightness: Brightness.light,
).show(
  context,
);
```

* Show dark rectangle snackbar

```dart
AnimatedSnackBar.rectangle(
'Success',
  'This is a success snack bar',
  type: AnimatedSnackBarType.success,
  brightness: Brightness.dark,
).show(
  context,
);
```

* Show a custom snackbar

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
