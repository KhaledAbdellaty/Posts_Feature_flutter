import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../core/constants/strings/failuer.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usescases/get_all_post.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final postsOrFailure = await getAllPostsUseCase();
        emit(_mapFailureOrPostToState(postsOrFailure));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final postsOrFailure = await getAllPostsUseCase();
        emit(_mapFailureOrPostToState(postsOrFailure));
      }
    });
  }

  PostsState _mapFailureOrPostToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) =>
            ErrorPostsState(messageError: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
