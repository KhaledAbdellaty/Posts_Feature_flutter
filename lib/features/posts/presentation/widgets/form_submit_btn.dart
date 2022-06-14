import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isUpdate;
  const SubmitBtn({Key? key, required this.isUpdate, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdate ? Icons.update : Icons.add),
      label: Text(isUpdate ? 'Update' : 'Add'),
    );
  }
}
