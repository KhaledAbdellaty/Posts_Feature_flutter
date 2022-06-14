import '../../../../../../core/widgets/loading_widget.dart';
import '../../../../../../core/widgets/snackbar_message.dart';
import '../../../bloc/add_delete_update-posts/add_delete_update_bloc.dart';
import '../../home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../widgets/form_body_widget.dart';

class PostAddBody extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddBody({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrDeleteOrUpdateBloc, AddOrDeleteOrUpdateState>(
        builder: (context, state) {
      if (state is LoadingAddOrDeleteOrUpdate) {
        return const LoadingWidget();
      }
      return FormWidget(
        isUpdate: isUpdate,
        post: isUpdate? post! : null,
      );
    }, listener: (context, state) {
      if (state is ErrorAddOrDeleteOrUpdate) {
        SnackBarMessage()
            .showErrorMessage(message: state.messageError, context: context);
      } else if (state is MessageAddOrDeleteOrUpdate) {
        SnackBarMessage()
            .showSuccessMessage(message: state.message, context: context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false);
      }
    });
  }
}
