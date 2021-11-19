import 'dart:async';

class NoteIsFavoriteBloc {
  final _noteIsFavoriteController = StreamController<bool>();

  Stream<bool> get noteIsFavoriteStream => _noteIsFavoriteController.stream;

  void dispose() {
    _noteIsFavoriteController.close();
  }

  void setNoteIsFavorite(bool isFavorite) {
    _noteIsFavoriteController.sink.add(isFavorite);
  }

}
