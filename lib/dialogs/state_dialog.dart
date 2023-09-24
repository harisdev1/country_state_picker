import 'package:flutter/material.dart';

class StateDialog extends StatefulWidget {
  final List<String> states;
  final Function(String) onSelectState;

  const StateDialog({
    super.key,
    required this.states,
    required this.onSelectState,
  });

  @override
  StateDialogState createState() => StateDialogState();
}

class StateDialogState extends State<StateDialog> {
  String searchState = "";

  @override
  Widget build(BuildContext context) {
    List<String> filteredStates = widget.states.where((state) {
      final lowerCaseState = state.toLowerCase();
      final lowerCaseSearch = searchState.toLowerCase();
      if (lowerCaseState.startsWith(lowerCaseSearch)) {
        return true; // Match items starting with the search text
      } else {
        return lowerCaseState.contains(lowerCaseSearch); // Match items containing the search text
      }
    }).toList();

    return AlertDialog(
      title: const Text("Select State"),
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
                  searchState = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Search State",
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredStates.length,
                itemBuilder: (context, index) {
                  final state = filteredStates[index];
                  return ListTile(
                    title: Text(state),
                    onTap: () {
                      widget.onSelectState(state);
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
