import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final List<dynamic> selected;
  final Function(List<dynamic>) onSelect;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final type = question["type"];
    final options = question["options"];

    if (type == "tf") {
      return Column(
        children: ["True", "False"].map((e) {
          return RadioListTile(
            title: Text(e),
            value: e,
            groupValue: selected.isEmpty ? null : selected[0],
            onChanged: (v) => onSelect([v]),
          );
        }).toList(),
      );
    }

    if (type == "single") {
      return Column(
        children: options.map<Widget>((e) {
          return RadioListTile(
            title: Text(e),
            value: e,
            groupValue: selected.isEmpty ? null : selected[0],
            onChanged: (v) => onSelect([v]),
          );
        }).toList(),
      );
    }

    // multi select
    return Column(
      children: options.map<Widget>((e) {
        return CheckboxListTile(
          title: Text(e),
          value: selected.contains(e),
          onChanged: (v) {
            final s = List.of(selected);
            v == true ? s.add(e) : s.remove(e);
            onSelect(s);
          },
        );
      }).toList(),
    );
  }
}
