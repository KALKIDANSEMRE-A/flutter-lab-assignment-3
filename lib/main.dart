import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:album_app/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:album_app/features/albums/presentation/pages/albums_page.dart';
import 'package:album_app/features/albums/presentation/pages/album_detail_page.dart';
import 'package:album_app/features/albums/data/datasources/albums_remote_data_source.dart';
import 'package:album_app/features/albums/domain/repositories/albums_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final remoteDataSource = AlbumsRemoteDataSourceImpl(client: httpClient);
    final repository = AlbumsRepositoryImpl(remoteDataSource: remoteDataSource);
    final albumsBloc = AlbumsBloc(repository: repository);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AlbumsPage(),
        ),
        GoRoute(
          path: '/album/:id',
          builder: (context, state) {
            final albumId = int.parse(state.pathParameters['id']!);
            return AlbumDetailPage(albumId: albumId);
          },
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: albumsBloc),
      ],
      child: MaterialApp.router(
        title: 'Album App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
} 