import 'package:pomodoro_desktop/Domain/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> fetchTodos();

  Future<void> createTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(String id);

}