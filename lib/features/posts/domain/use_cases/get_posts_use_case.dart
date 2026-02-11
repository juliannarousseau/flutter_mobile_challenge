import 'package:flutter_mobile_challenge/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/repository/post_repository_interface.dart';


class GetPostsUseCase {
  final PostRepositoryInterface repository; //Injeção de dependência do repositório

  GetPostsUseCase(this.repository); //Construtor que recebe o repositório

  Future<List<PostEntity>> call() async { //Função assincrona para pegar a lista de posts
    return await repository.getPostList(); //Chama a função do repositório para pegar a lista de posts
  }
}