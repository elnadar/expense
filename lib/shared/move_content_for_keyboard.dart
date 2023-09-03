import 'package:flutter/material.dart';

class MoveContentForKeyboard extends StatelessWidget {
  const MoveContentForKeyboard({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );
  }
}
