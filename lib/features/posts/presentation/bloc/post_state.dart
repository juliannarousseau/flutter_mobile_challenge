import 'package:equatable/equatable.dart';
import '../../domain/entities/post_entity.dart';

abstract class PostsState extends Equatable { //Classe base, não é instanciável
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {} // Estado inicial (nada carregado)

class PostsLoading extends PostsState {} // Carregando dados (ex: mostra spinner)

class PostsLoaded extends PostsState { // Sucesso: lista de posts carregada
  final List<PostEntity> posts;
  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostLoaded extends PostsState { // Sucesso: um post específico carregado
  final PostEntity post;
  const PostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

class PostsError extends PostsState { // Erro: algo deu errado
  final String message;
  const PostsError(this.message);

  @override
  List<Object> get props => [message];
}

/*O Que é PostsState?
Definição Técnica: É uma classe que representa o estado da UI (dados ou status exibidos). 
Estados são imutáveis e mudam em resposta a eventos.*/