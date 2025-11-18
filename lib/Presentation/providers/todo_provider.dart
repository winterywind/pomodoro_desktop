import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Data/repository/hive_todo_repo_impl.dart';
import 'package:pomodoro_desktop/Domain/models/todo.dart';


class TodoProvider extends ChangeNotifier {

  final HiveTodoRepoImpl todoRepo;
  TodoProvider({required this.todoRepo});

  List<Todo> _todos = [];
  final List<Todo> _todosNow = [];
  bool _isNow = false;

  List<Todo> get todos => _todos;
  List<Todo> get todosNow => _todosNow;
  bool get isNow => _isNow;



  Future<void> fetchTodos() async {
    _todos = await todoRepo.fetchTodos();
    for (var item in _todos) {
      if (item.isNow) {
        _todosNow.add(item);
      }
    }
    notifyListeners();
  }

  Future<void> insertTodo(Todo todo) async {
    await todoRepo.createTodo(todo);
    _todos.add(todo);
    if (todo.isNow) {
      _todosNow.add(todo);
    }
    notifyListeners();
  }

  Future<void> checkTodo(Todo todo) async {
    todo.checkTodo();
    notifyListeners();
    await todoRepo.updateTodo(todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    _todos.remove(todo);
    if (_todosNow.contains(todo)){
      _todosNow.remove(todo);
    }
    notifyListeners();
    await todoRepo.deleteTodo(todo.id);
  }

  void openNow() {
    _isNow = true;
    notifyListeners();
  }

  void openAll() {
    _isNow = false;
    notifyListeners();
  }

  Future<void> addToNow(Todo todo) async {
    if (_todosNow.contains(todo)){
      return;
    }
    todo.isNow = true;
    _todosNow.add(todo);
    notifyListeners();
    await todoRepo.updateTodo(todo);
  }
}