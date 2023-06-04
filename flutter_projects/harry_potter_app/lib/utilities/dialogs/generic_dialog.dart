import 'package:flutter/material.dart';

// typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<dynamic> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required Map<String, T?> optionsBuilder,
}) {
  // final options = optionsBuilder();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: optionsBuilder.keys.map((optionTitle) {
          final value = optionsBuilder[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
