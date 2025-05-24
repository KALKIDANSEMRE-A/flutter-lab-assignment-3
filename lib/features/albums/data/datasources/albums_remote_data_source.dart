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
    print('Fetching albums from API...');
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final albums = jsonList.map((json) => Album.fromJson(json)).toList();
      print('Successfully fetched ${albums.length} albums');
      return albums;
    } else {
      print('Failed to load albums. Status code: ${response.statusCode}');
      throw Exception('Failed to load albums');
    }
  }

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    print('Fetching photos for album $albumId from API...');
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$albumId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final photos = jsonList.map((json) => Photo.fromJson(json)).toList();
      print('Successfully fetched ${photos.length} photos for album $albumId');
      return photos;
    } else {
      print('Failed to load photos. Status code: ${response.statusCode}');
      throw Exception('Failed to load photos');
    }
  }
} 