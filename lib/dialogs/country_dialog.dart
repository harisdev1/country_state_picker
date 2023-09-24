import 'package:flutter/material.dart';

class CountryDialog extends StatefulWidget {
  final List<String> countries;
  final Function(String) onSelectCountry;

  const CountryDialog({
    super.key,
    required this.countries,
    required this.onSelectCountry,
  });

  @override
  CountryDialogState createState() => CountryDialogState();
}

class CountryDialogState extends State<CountryDialog> {
  String searchCountry = "";

  @override
  Widget build(BuildContext context) {
    List<String> filteredCountries = widget.countries.where((country) {
      final lowerCaseCountry = country.toLowerCase();
      final lowerCaseSearch = searchCountry.toLowerCase();
      return lowerCaseCountry.startsWith(lowerCaseSearch);
    }).toList();

    return AlertDialog(
      title: const Text("Select Country"),
      content: Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchCountry = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Search Country",
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return ListTile(
                    title: Text(country),
                    onTap: () {
                      widget.onSelectCountry(country);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
