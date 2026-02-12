import 'package:dartz/dartz.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/shared/typedefs.dart';


abstract class PostRepositoryInterface {
 AsyncResultPosts<List<PostEntity>> getPostList();
 AsyncResultPosts<PostEntity> getPostById(int id);
 //AsyncResultPosts<void> savePost(PostEntity post);
 //AsyncResultPosts<List<PostEntity>> getSavedPosts();
}