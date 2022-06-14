import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post_entity.dart';
import '../bloc/add_delete_update-posts/add_delete_update_bloc.dart';
import 'custom_text_field.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdate;
  const FormWidget({Key? key, this.post, required this.isUpdate})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _title.text = widget.post!.title;
      _body.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFormField(
            hint: 'Title',
            isMultiLines: false,
            controller: _title,
          ),
          CustomTextFormField(
            hint: 'Body',
            isMultiLines: true,
            controller: _body,
          ),
          SubmitBtn(isUpdate: widget.isUpdate, onPressed: _validate)
        ],
      ),
    );
  }

  void _validate() {
    final validate = _formKey.currentState!.validate();
    if (validate) {
      final post = Post(
        title: _title.text,
        body: _body.text,
        id: widget.isUpdate ? widget.post!.id : null,
      );
      if (widget.isUpdate) {
        BlocProvider.of<AddOrDeleteOrUpdateBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddOrDeleteOrUpdateBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
