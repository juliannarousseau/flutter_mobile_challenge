import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsRequested extends PostsEvent {} // Evento específico: carregar posts

class LoadPostByIdRequested extends PostsEvent { // Evento com parâmetro
  final int id;
  const LoadPostByIdRequested(this.id);

  @override
  List<Object> get props => [id];
}

class SavePostRequested extends PostsEvent { // Outro evento
  final int postId;
  const SavePostRequested(this.postId);

  @override
  List<Object> get props => [postId];
}