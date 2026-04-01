import 'package:flutter/material.dart';

class CustomRadioList<T> extends StatelessWidget {
  const CustomRadioList({
    super.key,
    required this.values,
    required this.groupValue,
    required this.onChanged,
    required this.titleBuilder,
  });

  final List<T> values;
  final T groupValue;
  final Function(T value) onChanged;
  final String Function(T value) titleBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(values.length, (index) {
        final value = values[index];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleBuilder(value),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ],
        );
      }),
    );
  }
}
