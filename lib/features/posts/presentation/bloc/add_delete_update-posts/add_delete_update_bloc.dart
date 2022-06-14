import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/strings/failuer.dart';
import '../../../../../core/constants/strings/messages.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usescases/add_post.dart';
import '../../../domain/usescases/delete_post.dart';
import '../../../domain/usescases/update_post.dart';
part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddOrDeleteOrUpdateBloc
    extends Bloc<AddOrDeleteOrUpdateEvent, AddOrDeleteOrUpdateState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddOrDeleteOrUpdateBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddOrDeleteOrUpdateInitial()) {
    on<AddOrDeleteOrUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddOrDeleteOrUpdate());
        final doneMessageOrFailure = await addPost(event.post);
        emit(_eitherDoneMessageOrFailure(
            doneMessageOrFailure, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddOrDeleteOrUpdate());
        final doneMessageOrFailure = await updatePost(event.post);
        emit(_eitherDoneMessageOrFailure(
            doneMessageOrFailure, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddOrDeleteOrUpdate());
        final doneMessageOrFailure = await deletePost(event.postId);
        emit(_eitherDoneMessageOrFailure(
            doneMessageOrFailure, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
  AddOrDeleteOrUpdateState _eitherDoneMessageOrFailure(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorAddOrDeleteOrUpdate(
            messageError: _mapFailureToMessage(failure)),
        (unit) => MessageAddOrDeleteOrUpdate(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
