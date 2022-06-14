import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';
import 'widgets/post_add_body.dart';

class PostAddScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddScreen({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PostAddBody(
        isUpdate: isUpdate,
        post: post,
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text(isUpdate ? 'Update' : 'Add'));
}
