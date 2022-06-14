import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase({required this.repository});
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
