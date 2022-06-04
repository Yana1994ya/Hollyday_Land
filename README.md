# Hollyday Land

An educational project to help users plan their next vacation.

## Run instructions

To run this project flutter (2.10.4) is required, if any problems are encountered run
`flutter doctor` and ensure the setup works well.

### Running in VSCode

to run in VSCode, ensure flutter plugin is installed, go into any *.dart file and click the run
button.

### Running in Android Studio

Ensure Flutter plugging is installed, go into main.dart and click the run button.

### Run from terminal

To run from the terminal, in the root of the project, type `flutter run`

## Supported platforms

Out of all the platforms Flutter supports, only Android is tested and supported.

## Code generation

This project requires code generation using a different project:
https://github.com/Yana1994ya/hollyday_land_dao

Clone this directory into the same parent as this project, than run
`flutter pub run build_runner build --delete-conflicting-outputs`
from the root directory of this project.

To rebuild all the automatically generated code.

## Api server

This project depends on API server available at:
https://github.com/Yana1994ya/hland_django

## API Keys

This project requires API Keys from firebase that are not committed.

First go to project settings in firebase and click to download `google-service.json`, place the file
in `android/app/google-services.json`

Create `android/app/src/main/res/values/configuration.xml`

With the content:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_maps_api_key"></string>
</resources>
```

with the key from `api_key/current_key`