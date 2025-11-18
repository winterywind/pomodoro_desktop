import 'package:pomodoro_desktop/Domain/models/todo.dart';
import 'package:hive/hive.dart';


part 'todo_data.g.dart';

@HiveType(typeId: 0)
class HiveTodo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool completed;

  @HiveField(3)
  bool isNow;

  HiveTodo({required this.id, required this.title, required this.completed, required this.isNow});

  factory HiveTodo.fromDomain(Todo todo) {
    return HiveTodo(id: todo.id, title: todo.title, completed: todo.completed, isNow: todo.isNow);
  }

  Todo toDomain(){
    return Todo(id: id, title: title, completed: completed, isNow: isNow);
  }
}