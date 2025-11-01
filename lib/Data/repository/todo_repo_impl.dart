import 'package:pomodoro_desktop/Data/datasources/todo_datasource.dart';
import 'package:pomodoro_desktop/Domain/models/todo.dart';
import 'package:pomodoro_desktop/Domain/repos/todo_repo.dart';

class TodoRepoImpl implements TodoRepo{
  final TodoDatasource dataSource;
  TodoRepoImpl({required this.dataSource});

  @override
  Future<List<Todo>> fetchTodos() async {
    return await dataSource.fetchTodos();
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    return await dataSource.insertTodo(todo);
  }

  @override
  Future<void> checkTodo(int id, bool newValue) async {
    return await dataSource.checkTodo(id, newValue);
  }

  @override
  Future<void> deleteTodo(int id) async {
    return await dataSource.deleteTodo(id);
  }

  @override
  Future<void> addToNow(Todo todo) async {
    return await dataSource.addToNow(todo);
  }
}