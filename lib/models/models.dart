import 'package:uuid/uuid.dart';

class Notes {
  int id;
  String title;
  String description;
  bool isFavorite;

  Notes(this.title, this.description) : id = Uuid().v4().hashCode,isFavorite = false;
}
