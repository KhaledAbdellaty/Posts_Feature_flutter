import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';
import 'widgets/post_details_body.dart';

class PostDetalisScreen extends StatelessWidget {
  final Post post;
  const PostDetalisScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PostDetailsBody(
        post: post,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(post.title),
    );
  }
}
