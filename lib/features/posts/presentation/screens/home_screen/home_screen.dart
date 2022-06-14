import 'package:flutter/material.dart';

import '../post_add_screen/post_add_screen.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionBtn(context),
      body: const HomeBody(),
    );
  }

  FloatingActionButton _buildFloatingActionBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PostAddScreen(
              isUpdate: false,
            ),
          ),
        );
      }),
      child: const Icon(Icons.add),
    );
  }
}
