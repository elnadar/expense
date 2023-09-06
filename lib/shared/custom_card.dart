import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({super.key, this.child, this.color, this.marign});
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? marign;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color ?? Colors.transparent,
      margin: marign,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: child,
    );
  }
}
