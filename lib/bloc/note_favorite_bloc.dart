import 'dart:async';

class NoteFavoriteBloc {
  final _noteFavoriteController = StreamController<bool>();

  StreamSink<bool> get _noteIsFavoriteSink => _noteFavoriteController.sink;
  Stream<bool> get _noteIsNotFavoriteStream => _noteFavoriteController.stream;

  NoteFavoriteBloc() {
    _noteIsNotFavoriteStream.listen(_noteIsFavoriteSink.add);
  }
}
