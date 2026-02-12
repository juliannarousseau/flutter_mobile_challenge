import 'package:dio/dio.dart';
import 'package:flutter_mobile_challenge/features/auth/data/model/user_model.dart';
import 'package:flutter_mobile_challenge/features/posts/data/datasource/post_datasource_interface.dart';
import 'package:flutter_mobile_challenge/features/posts/data/model/post_model.dart';

class PostsDioDatasource implements PostsDatasourceInterface {
  final Dio dio;

  PostsDioDatasource(this.dio);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data; // Dio já decodifica JSON
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/$id');
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw Exception('Erro ao buscar post');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users/$id');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }
}