# /rpg Command

## Description
Recursive `flutter pub get` -- find every `pubspec.yaml` under the current working directory and run `flutter pub get` in each.

## Instructions
1. Find all directories containing a `pubspec.yaml` under the current working directory
2. Run `flutter pub get` in each directory, starting from the deepest (leaf) packages first
3. Print a summary line for each package (success / failure)
4. At the end, print a totals summary (passed / failed)
