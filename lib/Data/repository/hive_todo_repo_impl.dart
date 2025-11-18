import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomodoro_desktop/Data/model/todo_data.dart';
import 'package:pomodoro_desktop/Domain/models/todo.dart';
import 'package:pomodoro_desktop/Domain/repos/todo_repo.dart';

class HiveTodoRepoImpl implements TodoRepo{
  static const _boxName = 'todos';

  Box<HiveTodo> get _box {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<HiveTodo>(_boxName);
    } else {
      throw Exception('Box is not opened yet');
    }
  }

  HiveTodo _toHiveTodo(Todo todo) => HiveTodo.fromDomain(todo);

  Todo _toDomainTodo(HiveTodo hiveTodo) => hiveTodo.toDomain();

  @override
  Future<List<Todo>> fetchTodos() async {
    final box = _box;
    return box.values.map(_toDomainTodo).toList();
  }

  @override
  Future<void> createTodo(Todo todo) async {
    final box = _box;
    HiveTodo hiveTodo = _toHiveTodo(todo);
    await box.put(todo.id, hiveTodo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final box = _box;
    box.delete(id);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final box = _box;
    HiveTodo hiveTodo = _toHiveTodo(todo);
    await box.put(todo.id, hiveTodo);
  }
}