import 'package:flutter/material.dart';

class DeleteBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
    );
  }
}
