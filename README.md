# AnimatedSnackBar

A Flutter package to show beautiful animated snackbars directly using overlay.

## Features

- Material-UI

![](https://github.com/JulyWitch/animated_snack_bar/blob/master/files/material.gif?raw=true)

<img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/material-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/material-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/material-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/material-error.png" height="600">

- Colorized rectangle

<img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/colorized-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/colorized-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/colorized-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/colorized-error.png" height="600">

- Dark rectangle

<img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/dark-info.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/dark-success.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/dark-warning.png" height="600"> <img src="https://github.com/JulyWitch/animated_snack_bar/raw/master/files/dark-error.png" height="600">

## Getting started

Add package to pubspec.yaml

```bash
flutter pub add animated_snack_bar
```

Import the package

```dart
import 'package:animated_snack_bar/animated_snack_bar.dart';
```

## Usage

- Show material ui snackbar

```dart
AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.info,
).show(context);
```

- Show colorized rectangle snackbar

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

- Show dark rectangle snackbar

```dart
AnimatedSnackBar.rectangle(
'Success',
  'This is a success snack bar',
  type: AnimatedSnackBarType.success,
  brightness: Brightness.dark,
).show(context);
```

- Remove a snackbar

```dart
final snackbar = AnimatedSnackBar(
    builder: ((context) {
        return Container(
            padding: const EdgeInsets.all(8),
            color: Colors.amber,
            height: 50,
            child: const Text('A custom snackbar'),
        );
    }),
);
snackbar.show(context);

snackbar.remove()
```

- Remove all snackbars

```dart
AnimatedSnackBar.removeAll();
```

- Show

- Show a custom snackbar

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

- Show a custom snackbar with MaterialAnimatedSnackBar content

```dart
AnimatedSnackBar(
  builder: ((context) {
    return const MaterialAnimatedSnackBar(
      titleText: 'Custom material snackbar ',
      messageText:
          'This a custom material snackbar with info type',
      type: AnimatedSnackBarType.info,
      foregroundColor: Colors.amber,
      titleTextStyle: TextStyle(
        color: Colors.brown,
      ),
    );
  }),
).show(context);
```

- Changning snackbar pushing position

```dart
AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.info,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom, // Position of snackbar on mobile devices
    desktopSnackBarPosition: DesktopSnackBarPosition.topRight, // Position of snackbar on desktop devices
).show(context);
```

- Change snack bar position for mobile

```dart
AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.info,
    mobilePositionSettings: const MobilePositionSettings(
      topOnAppearance: 100,
      // topOnDissapear: 50,
      // bottomOnAppearance: 100,
      // bottomOnDissapear: 50,
      // left: 20,
      // right: 70,
    ),
).show(context);
```

### Multiple snack bars handling

You can pass `snackBarStrategy` as a paramter to determine what should snack bar do
with snackbars which came before it.

- Should it be shown on them like column? use `ColumnSnackBarStrategy`
- Should it remove them? use `RemoveSnackBarStrategy`
- Should it just stack on them? use `StackSnackBarStrategy`
