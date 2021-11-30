import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';

class KeyboardMenuButton extends StatelessWidget {
  const KeyboardMenuButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => const Size(66, 56)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => deepOrange)),
        onPressed: onPressed,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
