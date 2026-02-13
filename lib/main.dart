import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/bloc/post_bloc.dart';
import 'package:flutter_mobile_challenge/features/posts/presentation/pages/post_page.dart';
import 'package:flutter_mobile_challenge/shared/di/injection.dart';




void main() {
  setupDependencies(); // Configura injeção de dependências
  runApp(const MyApp()); 
}


class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 17, 42, 206),
      ),
      home: BlocProvider(
        create: (context) => getIt<PostsBloc>(), // Fornece PostsBloc via GetIt
        child: const PostPage(), // Página inicial
      ),
    );
  }
}