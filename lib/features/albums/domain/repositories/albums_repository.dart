import 'package:album_app/features/albums/domain/models/album.dart';
import 'package:album_app/features/albums/domain/models/photo.dart';
import 'package:album_app/features/albums/data/datasources/albums_remote_data_source.dart';

abstract class AlbumsRepository {
  Future<List<Album>> getAlbums();
  Future<List<Photo>> getPhotos(int albumId);
}

class AlbumsRepositoryImpl implements AlbumsRepository {
  final AlbumsRemoteDataSource remoteDataSource;

  AlbumsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Album>> getAlbums() async {
    return await remoteDataSource.getAlbums();
  }

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    return await remoteDataSource.getPhotos(albumId);
  }
} 