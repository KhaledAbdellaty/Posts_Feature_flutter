import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
