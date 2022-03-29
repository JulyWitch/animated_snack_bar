# AnimatedSnackBar

A Flutter package to show beautiful animated snackbars directly using overlay.

## Features

- Material-UI

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material.gif?raw=true)

- Colorized rectangle

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-info.png)
![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-success.png)
![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/colorized-warning.png)


- Dark rectangle

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/dark-error.png)

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
