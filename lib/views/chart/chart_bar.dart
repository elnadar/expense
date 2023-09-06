import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {super.key,
      required this.weight,
      required this.total,
      required this.height});
  final double weight;
  final double total;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: height - (weight / total * height)),
        SizedBox(
          height: weight / total * height,
          width: 30,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16))),
          ),
        ),
      ],
    );
  }
}
