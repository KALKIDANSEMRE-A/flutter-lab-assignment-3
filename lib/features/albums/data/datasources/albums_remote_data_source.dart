import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:album_app/features/albums/domain/models/album.dart';
import 'package:album_app/features/albums/domain/models/photo.dart';

abstract class AlbumsRemoteDataSource {
  Future<List<Album>> getAlbums();
  Future<List<Photo>> getPhotos(int albumId);
}

class AlbumsRemoteDataSourceImpl implements AlbumsRemoteDataSource {
  final http.Client client;

  AlbumsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Album>> getAlbums() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$albumId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
} 