import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';

abstract class PostRepositoryInterface {
 Future <List <PostEntity>> getPostList();
}