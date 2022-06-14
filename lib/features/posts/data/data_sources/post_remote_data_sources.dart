import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/strings/network_api.dart';
import '../../../../core/error/exception.dart';
import '../model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int id);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImp extends PostRemoteDataSource {
  Dio dio;

  PostRemoteDataSourceImp({required this.dio}) {
    BaseOptions options = BaseOptions(
      receiveTimeout: 20 * 1000, // 20 seconds
      connectTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  @override
  Future<Unit> addPost(PostModel postModel) async {
    final data = {
      'title': postModel.title,
      'bpdy': postModel.body,
    };

    final response = await dio.post(url, data: data);
    if (response.statusCode == 201) {
      return Future.value(unit);
    }
    throw ServerException();
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await dio.delete(url + id.toString());
    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    throw ServerException();
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      final List<PostModel> list =
          data.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return list;
    }
    return throw ServerException();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final newData = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await dio.patch(url + postId, data: newData);

    if (response.statusCode == 200) {
      return Future.value(unit);
    }
    throw ServerException();
  }
}
