import 'package:flutter_mobile_challenge/features/auth/data/model/user_model.dart';
import 'package:flutter_mobile_challenge/features/posts/data/model/post_model.dart';

abstract class PostsDatasourceInterface {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
  Future<UserModel> getUserById(int id);
}