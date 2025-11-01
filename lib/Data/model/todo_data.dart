import 'package:pomodoro_desktop/Domain/models/todo.dart';

class DataTodo {
  int? id;
  String title;
  bool completed;
  bool isNow;

  DataTodo({this.id, required this.title, this.completed = false, required this.isNow});

  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      completed: completed,
      isNow: isNow
    );
  }

  factory DataTodo.fromDomain(Todo todo) {
    return DataTodo(
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
      isNow: todo.isNow
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'title': title,
      'completed': completed ? 1 : 0,
      'is_now': isNow ? 1 : 0
    };
    if (id != null) {
      map['id'] = id!;
    }

    return map;
  }

  factory DataTodo.fromMap(Map<String, dynamic> map) {
    return DataTodo(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
      isNow: map['is_now'] == 1,
    );
  }
}