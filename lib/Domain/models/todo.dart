class Todo {
  String id;
  String title;
  bool completed;
  bool isNow;

  Todo({required this.id, required this.title, this.completed = false, required this.isNow});

  void checkTodo() {
    completed = !completed;
  }
}