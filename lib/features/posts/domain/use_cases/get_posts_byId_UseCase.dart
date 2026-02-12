import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mobile_challenge/shared/typedefs.dart';

class GetPostByIdUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  GetPostByIdUseCase(this.repository); //Construtor que recebe o repositório

  
  AsyncResultPosts<PostEntity> call(int id) async { //Função assincrona para pegar um post pelo ID
    return await repository.getPostById(id); //Chama a função do repositório para pegar o post pelo ID
  }
}