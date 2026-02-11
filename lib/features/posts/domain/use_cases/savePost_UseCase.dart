import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';
import 'package:dartz/dartz.dart';

class SavePostUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  SavePostUseCase(this.repository); //Construtor que recebe o repositório

  Future<Either<Exception, void>> call(PostEntity post) async { //Função assincrona para salvar um post
    if (!post.isValid()) { //Verifica se o post é válido
      return Left(Exception('Post inválido')); //Retorna uma exceção caso o post seja inválido
    }
    return await repository.savePost(post); //Chama a função do repositório para salvar o post
  }
}