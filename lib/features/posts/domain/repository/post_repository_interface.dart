import 'package:dartz/dartz.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/shared/typedefs.dart';


abstract class PostRepositoryInterface {
 APELIDOLEGAL<List<PostEntity>> getPostList();
 APELIDOLEGAL<PostEntity> getPostById(int id);
 //APELIDOLEGAL<void> savePost(PostEntity post);
 //APELIDOLEGAL<List<PostEntity>> getSavedPosts();
}