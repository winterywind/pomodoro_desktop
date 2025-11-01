class Todo {
  int? id;
  String title;
  bool completed;
  bool isNow;

  Todo({this.id, required this.title, this.completed = false, required this.isNow});

  void checkTodo() {
    completed = !completed;
  }
}