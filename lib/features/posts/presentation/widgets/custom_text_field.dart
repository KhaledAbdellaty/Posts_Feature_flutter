import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool isMultiLines;
  final String hint;
  final TextEditingController controller;
  const CustomTextFormField(
      {Key? key,
      required this.hint,
      required this.isMultiLines,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
        ),
        minLines: isMultiLines ? 6 : 1,
        maxLines: isMultiLines ? 6 : 1,
        controller: controller,
        validator: (val) => val!.isEmpty ? '$hint can\'t be embty' : null,
      ),
    );
  }
}
