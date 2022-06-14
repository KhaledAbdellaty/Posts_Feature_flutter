import 'posts_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/loading_widget.dart';
import '../../../../../../core/widgets/snackbar_message.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../bloc/Posts/posts_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          List<Post> posts = state.posts;
          return RefreshIndicator(
              child: PostsListViewWidget(posts: posts),
              onRefresh: () => _refreshPosts(context));
        } else if (state is ErrorPostsState) {
          return Center(
            child: Text(state.messageError),
          );
        }
        return const LoadingWidget();
      },
    );
  }

  Future<void> _refreshPosts(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
    SnackBarMessage()
        .showSuccessMessage(message: 'Refreshed', context: context);
  }
}
