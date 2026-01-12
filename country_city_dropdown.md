# Custom CSC Picker (Country & City Only)

A customized version of `csc_picker_plus` that supports a **Country -> City** flow, skipping the **State** selection.

## Features
- **Skip State Selection:** Set `showStates: false` and `showCities: true` to display only Country and City dropdowns.
- **Auto-Aggregated Cities:** When State selection is hidden, picking a Country will automatically load cities from **all states** in that country.
- **Custom Styling:** Enhanced padding and spacing to match modern UI designs.

## Dependencies

This widget relies on the assets (JSON database) from the `csc_picker_plus` package.

1.  Add `csc_picker_plus` to your project's `pubspec.yaml`:

```yaml
dependencies:
  csc_picker_plus: ^0.0.3  # or latest version
```

## Installation

1.  Copy the entire `custom_csc_picker` folder to your project (e.g., in `lib/widgets/`).
2.  Import the widget in your file.

## Usage

```dart
import 'package:your_project/widgets/custom_csc_picker/custom_csc_picker.dart';

// ...

CustomCSCPicker(
  showStates: false, // Hide State dropdown
  showCities: true,  // Show City dropdown
  layout: Layout.vertical,
  flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
  onCountryChanged: (value) {
    print("Country selected: $value");
  },
  onStateChanged: (value) {
    // Optional: will be null when showStates is false
  },
  onCityChanged: (value) {
    print("City selected: $value");
  },
  // ... Styling parameters ...
  dropdownDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    border: Border.all(color: Colors.grey, width: 1),
  ),
),
```

## Internal Structure
- `custom_csc_picker.dart`: Main widget logic. Modified to flatten city lists when states are hidden.
- `dropdown_with_search.dart`: Helper widget for the dropdown UI.
- `model/`: Contains data models (`Country`, `Region`, `City`).
