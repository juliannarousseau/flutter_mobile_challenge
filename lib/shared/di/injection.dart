import 'package:flutter_mobile_challenge/features/posts/data/datasource/post_datasource_interface.dart';
import 'package:flutter_mobile_challenge/features/posts/data/datasource/post_http_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/use_cases/get_posts_UseCase.dart';
final getIt = GetIt.instance;

void setupDependencies() {
  // Registre dependências base
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<Dio>(() => Dio());

  // ESCOLHA AQUI: Comente/descomente para trocar
  getIt.registerLazySingleton<PostsDatasourceInterface>(
    () => PostsHttpDatasource(getIt<http.Client>()), // Para HTTP
    // () => PostsDioDatasource(getIt<Dio>()), // Para Dio
  );

  // Registre repositório, use cases, etc., usando PostsDatasourceInterface
}