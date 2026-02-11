import 'package:dartz/dartz.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';

abstract class PostRepositoryInterface {
 Future <List <PostEntity>> getPostList();
 Future<Either<Exception, PostEntity>> getPostById(int id);
 Future<Either<Exception, void>> savePost(PostEntity post);
 Future<Either<Exception, List<PostEntity>>> getSavedPosts();

}