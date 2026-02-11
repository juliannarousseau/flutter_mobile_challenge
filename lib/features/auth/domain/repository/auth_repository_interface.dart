import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';

abstract class AuthRepositoryInterface {
  Future loginUser();
  Future registerUser();

/// Future <List <PostEntity>> getPostList();
}


