part of 'add_delete_update_bloc.dart';

abstract class AddOrDeleteOrUpdateEvent extends Equatable {
  const AddOrDeleteOrUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddOrDeleteOrUpdateEvent {
  final Post post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddOrDeleteOrUpdateEvent {
  final Post post;

  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddOrDeleteOrUpdateEvent {
  final int postId;

  const DeletePostEvent({required this.postId});
    @override
  List<Object> get props => [postId];
}


