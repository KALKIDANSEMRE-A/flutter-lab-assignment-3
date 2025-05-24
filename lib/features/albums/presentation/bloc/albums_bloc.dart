import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:album_app/features/albums/domain/models/album.dart';
import 'package:album_app/features/albums/domain/models/photo.dart';
import 'package:album_app/features/albums/domain/repositories/albums_repository.dart';

// Events
abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlbums extends AlbumsEvent {}

class LoadPhotos extends AlbumsEvent {
  final int albumId;

  const LoadPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}

// States
abstract class AlbumsState extends Equatable {
  const AlbumsState();

  @override
  List<Object?> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  const AlbumsLoaded(this.albums);

  @override
  List<Object?> get props => [albums];
}

class PhotosLoaded extends AlbumsState {
  final List<Photo> photos;

  const PhotosLoaded(this.photos);

  @override
  List<Object?> get props => [photos];
}

class AlbumsError extends AlbumsState {
  final String message;

  const AlbumsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsRepository repository;

  AlbumsBloc({required this.repository}) : super(AlbumsInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<LoadPhotos>(_onLoadPhotos);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final albums = await repository.getAlbums();
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }

  Future<void> _onLoadPhotos(LoadPhotos event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final photos = await repository.getPhotos(event.albumId);
      emit(PhotosLoaded(photos));
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }
} 