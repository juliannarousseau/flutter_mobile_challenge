import 'package:flutter_mobile_challenge/features/posts/data/datasource/post_datasource_interface.dart';
import 'package:flutter_mobile_challenge/features/posts/data/datasource/post_http_datasource.dart';
import 'package:flutter_mobile_challenge/features/posts/data/repository/post_repository_impl.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/use_cases/get_posts_UseCase.dart';
final getIt = GetIt.instance;

void setupDependencies() {
  // Guard: evita registros duplicados
  if (getIt.isRegistered<GetPostsUseCase>()) {
    return;
  }

  // 1. HTTP Client (base)
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // 2. Datasource (HTTP ou Dio)
  getIt.registerLazySingleton<PostsDatasourceInterface>(
    () => PostsHttpDatasource(getIt<http.Client>()), // Para HTTP
    // () => PostsDioDatasource(getIt<Dio>()), // Para Dio
  );

  // 3. Repositório
  getIt.registerLazySingleton<PostRepositoryInterface>(
    () => PostsRepositoryImpl(getIt<PostsDatasourceInterface>()),
  );

  // 4. Use Cases
  getIt.registerLazySingleton<GetPostsUseCase>(
    () => GetPostsUseCase(getIt<PostRepositoryInterface>()),
  );

  // 5. Bloc
  getIt.registerFactory<PostsBloc>(
    () => PostsBloc(getIt<GetPostsUseCase>()),
  );
}