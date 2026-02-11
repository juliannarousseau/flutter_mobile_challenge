import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';
import 'package:dartz/dartz.dart';

class GetSavedPostsUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  GetSavedPostsUseCase(this.repository); //Construtor que recebe o repositório

  Future<Either<Exception, List<PostEntity>>> call() async { //Função assincrona para pegar a lista de posts
    return await repository.getSavedPosts(); //Chama a função do repositório para pegar a lista de posts salvos
  }
}