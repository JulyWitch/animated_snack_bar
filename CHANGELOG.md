## 0.4.0

- Breaking change: `AnimatedSnackBar().show(BuildContext context)` is not a `Future` anymore
- Add: `AnimatedSnackBar.removeAll()` method to remove all snack bars
- Fix: Rendering snackbar behind keyboard
- Fix: `AnimatedSnackBar().remove()` method to remove the snack bar
- Fix: Fadeout time when duration is short (Fadeout time is now 1/4 of the duration clamped between 100 ms to 2000 ms)

## 0.3.1

- Add: MobilePositionSettings to change position of snack bar

## 0.3.0

- Add: MultipleSnackBarStrategy
- Fix: Snack bar position in desktop

## 0.2.2

- Fix: Flutter 3 compability

## 0.2.1

- Fix: Readme images
- Fix: Pubspec description length

## 0.2.0

- Add: Determining snack bar position

- Add: ColorizedRectangle snack bars

- Add: Dark Rectangle snack bars

- Add: New icon assets for future releases

## 0.1.0

- Add: Material-UI snack bars
