import 'dart:convert';
import 'package:cs_picker/models/country_state_model.dart';
import 'package:cs_picker/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryStatePickerScreen extends StatefulWidget {
  const CountryStatePickerScreen({super.key});

  @override
  CountryStatePickerScreenState createState() => CountryStatePickerScreenState();
}

class CountryStatePickerScreenState extends State<CountryStatePickerScreen> {
  List<CountryModel> countries = [];
  String selectedCountry = "";
  String selectedState = "";
  late String jsonString;

  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    jsonString = await rootBundle.loadString('assets/country_states.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);
    countries = (jsonData['countries'] as List).map((json) => CountryModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country and State Picker"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: countryController,
                      decoration: const InputDecoration(
                        labelText: "Country",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () {
                        //    FocusManager.instance.primaryFocus?.unfocus();
                        _countryDialog(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: stateController,
                      decoration: const InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () {
                        //      FocusManager.instance.primaryFocus?.unfocus();
                        if (selectedCountry.isEmpty) {
                          _errorDialog(context);
                        } else {
                          _stateDialog(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _countryDialog(BuildContext context) {
    return AppDialogs().showCustomCountryPickerDialog(
      context,
      countries: countries.map((country) => country.country).toList(),
      onSelectCountry: (country) {
        setState(() {
          selectedCountry = country;
          countryController.text = country; // Set the text in the TextField
        });
      },
    );
  }

  Future<void> _stateDialog(BuildContext context) {
    return AppDialogs().showCustomStatePickerDialog(
      context,
      states: countries
          .firstWhere(
            (country) => country.country == selectedCountry,
            orElse: () => CountryModel(country: "", states: []),
          )
          .states,
      onSelectState: (state) {
        setState(() {
          selectedState = state;
          stateController.text = state; // Set the text in the TextField
        });
      },
    );
  }

  Future<void> _errorDialog(BuildContext context) {
    return AppDialogs().showCustomErrorDialog(
      context,
      errorMessage: "Please select a country first.",
    );
  }
}
