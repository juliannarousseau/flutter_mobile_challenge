import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_bloc.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_event.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_state.dart';


class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed de Posts')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial) {
            return const Center(child: Text('Bem-vindo! Pressione Carregar.'));
          }
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body.substring(0, 50) + '...'),
                  onTap: () {
                    // Navegar para detalhes (implemente depois)
                  },
                );
              },
            );
          }
          if (state is PostsError) {
            return Center(child: Text('Erro: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostsBloc>().add(LoadPostsRequested()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}