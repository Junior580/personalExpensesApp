import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final InputDecoration decoration;

  const AdaptativeTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            decoration: const BoxDecoration(),
            onChanged: onChanged,
          )
        : TextField(
            controller: controller,
            decoration: decoration,
            onChanged: onChanged,
          );
  }
}
