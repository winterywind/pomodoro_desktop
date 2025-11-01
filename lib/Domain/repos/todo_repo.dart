import 'package:pomodoro_desktop/Domain/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> fetchTodos();

  Future<Todo> createTodo(Todo todo);

  Future<void> checkTodo(int id, bool newValue);

  Future<void> deleteTodo(int id);

  Future<void> addToNow(Todo todo);
}