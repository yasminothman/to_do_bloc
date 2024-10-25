import 'package:isar/isar.dart';

import '../../domain/modals/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  //convert isar object -> pure todo object to use in our app
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  //convert pure todo object -> isar object to store in db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
