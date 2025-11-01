import 'package:pomodoro_desktop/Data/core/app_database.dart';
import 'package:pomodoro_desktop/Data/model/todo_data.dart';
import 'package:pomodoro_desktop/Domain/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatasource {
  final AppDatabase _appDatabase;
  TodoDatasource(this._appDatabase);

  Future<Database> get database async => await _appDatabase.database;

  Future<List<Todo>> fetchTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return maps.map((e) {
      final decryptedMap = Map<String, dynamic>.from(e);
      decryptedMap['title'] = _appDatabase.decryptText(decryptedMap['title']);
      final map = DataTodo.fromMap(decryptedMap);
      return map.toDomain();
    }).toList();
  }

  Future<Todo> insertTodo(Todo todo) async {
    final db = await database;
    final id = await db.insert('todos', {
      'title': _appDatabase.encryptText(todo.title),
      'completed': todo.completed ? 1 : 0,
      'is_now': todo.isNow ? 1 : 0,
    });
    todo.id = id;
    return todo;
  }

  Future<void> checkTodo(int id, bool newValue) async {
    final db = await database;
    await db.update('todos', {'completed': newValue ? 1 : 0}, where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> addToNow(Todo todo) async {
    final db = await database;
    await db.update('todos', {'is_now': 1}, where: 'id = ?', whereArgs: [todo.id!]);
  }
}