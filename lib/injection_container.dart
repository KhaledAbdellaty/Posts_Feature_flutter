import 'core/network/network_info.dart';
import 'features/posts/data/data_sources/post_local_data_sources.dart';
import 'features/posts/data/data_sources/post_remote_data_sources.dart';
import 'features/posts/data/repositories/post_repository.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/usescases/add_post.dart';
import 'features/posts/domain/usescases/delete_post.dart';
import 'features/posts/domain/usescases/get_all_post.dart';
import 'features/posts/domain/usescases/update_post.dart';
import 'features/posts/presentation/bloc/Posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/add_delete_update-posts/add_delete_update_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final inj = GetIt.instance;

Future<void> init() async {
  // Bloc
  inj.registerFactory(() => PostsBloc(getAllPostsUseCase: inj()));
  inj.registerFactory(() => AddOrDeleteOrUpdateBloc(
      addPost: inj(), deletePost: inj(), updatePost: inj()));

//UsesCases

  inj.registerLazySingleton(() => GetAllPostsUseCase(repository: inj()));
  inj.registerLazySingleton(() => AddPostUseCase(repository: inj()));
  inj.registerLazySingleton(() => DeletePostUseCase(repository: inj()));
  inj.registerLazySingleton(() => UpdatePostUseCase(repository: inj()));

  // Repositories

  inj.registerLazySingleton<PostsRepository>(() => PostRepositoryImp(
        postLocalDataSource: inj(),
        networkInfo: inj(),
        postRemoteDataSource: inj(),
      ));

  // DataSources

  inj.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: inj()));

  inj.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(dio: inj()));

  // Core

  inj.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: inj()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  inj.registerLazySingleton(() => sharedPreferences);
  inj.registerLazySingleton(() => Dio());
  inj.registerLazySingleton(() => InternetConnectionChecker());
}
