import '../../../../domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/add_delete_update-posts/add_delete_update_bloc.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/form_submit_btn.dart';
import 'form_delete_btn.dart';

class FormDetailsBody extends StatelessWidget {
  final Post post;
  const FormDetailsBody({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _title = TextEditingController();
    final _body = TextEditingController();

    _title.text = post.title;
    _body.text = post.body;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomTextFormField(
              hint: 'Title', isMultiLines: false, controller: _title),
          CustomTextFormField(
              hint: 'Body', isMultiLines: true, controller: _body),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeleteBtn(
                onPressed: () =>
                    BlocProvider.of<AddOrDeleteOrUpdateBloc>(context).add(
                  DeletePostEvent(postId: post.id!),
                ),
              ),
              SubmitBtn(
                isUpdate: true,
                onPressed: () =>
                    BlocProvider.of<AddOrDeleteOrUpdateBloc>(context).add(
                  UpdatePostEvent(post: post),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
