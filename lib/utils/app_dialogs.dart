import 'package:cs_picker/dialogs/country_dialog.dart';
import 'package:cs_picker/dialogs/error_dialog.dart';
import 'package:cs_picker/dialogs/state_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  Future<void> showCustomErrorDialog(BuildContext context, {required String errorMessage}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(errorMessage: errorMessage);
      },
    );
  }

  Future<void> showCustomStatePickerDialog(BuildContext context, {required List<String> states, required Function(String) onSelectState}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StateDialog(states: states, onSelectState: onSelectState);
      },
    );
  }

  Future<void> showCustomCountryPickerDialog(BuildContext context,
      {required List<String> countries, required Function(String) onSelectCountry}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CountryDialog(countries: countries, onSelectCountry: onSelectCountry);
      },
    );
  }
}
