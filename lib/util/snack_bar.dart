import 'package:flutter/material.dart';

void snack(text,
    {Color? color, required BuildContext context, int duration = 3}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: duration),
      closeIconColor: color != null
          ? Colors.white
          : Theme.of(context).colorScheme.onPrimary,
      backgroundColor: color,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            color: color != null
                ? Colors.white
                : Theme.of(context).colorScheme.onPrimary,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
