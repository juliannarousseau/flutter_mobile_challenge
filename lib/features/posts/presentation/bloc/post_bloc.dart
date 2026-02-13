import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_challenge/features/posts/domain/use_cases/get_posts_UseCase.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_event.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_state.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase; // Dependência injetada

  PostsBloc(this.getPostsUseCase) : super(PostsInitial()) { // Estado inicial
    on<LoadPostsRequested>(_onLoadPostsRequested); // Registra handler para evento
    // Adicione outros: on<LoadPostByIdRequested>(_onLoadPostByIdRequested);
  }

  Future<void> _onLoadPostsRequested(
    LoadPostsRequested event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading()); // Emite estado de carregamento
    final result = await getPostsUseCase.call(); // Chama use case
    result.fold(
      (error) => emit(PostsError(error.toString())), // Emite erro
      (posts) => emit(PostsLoaded(posts)), // Emite sucesso com dados
    );
  }

  // Adicione outros métodos handlers (ex.: _onLoadPostByIdRequested)
}