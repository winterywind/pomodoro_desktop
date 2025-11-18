import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/Domain/models/todo.dart';
import 'package:pomodoro_desktop/Presentation/l10n/app_localizations.dart';
import 'package:pomodoro_desktop/Presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _controller = TextEditingController();

  Set<String> selectedValues = {'all'};

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Consumer<TodoProvider>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.tasks, style: TextStyle(fontSize: 24)),
                  SizedBox(height: 10,),
                  SegmentedButton<String>(
                    segments: <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: 'all',
                        label: Text(
                          AppLocalizations.of(context)!.all,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ButtonSegment<String>(
                        value: 'now',
                        label: Text(
                          AppLocalizations.of(context)!.now,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    selected: selectedValues,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.deepPurple;
                        } else {
                          return null;
                        }
                      },)
                    ),
                    showSelectedIcon: false,
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        selectedValues = newSelection;
                      });
                      if (newSelection.first == 'now') {
                        value.openNow();
                      } else {
                        value.openAll();
                      }
                    },
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: _controller,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    onSubmitted: (title) {
                      final todo = Todo(title: title, isNow: value.isNow, id: Uuid().v4());
                      value.insertTodo(todo);
                      _controller.clear();
                    },

                    decoration: InputDecoration(label: Text(AppLocalizations.of(context)!.newTask)),
                  ),

                  SizedBox(height: 10,),

                  Expanded(
                    child: ListView.builder(
                      itemCount: value.isNow
                          ? value.todosNow.length
                          : value.todos.length,
                      itemBuilder: (context, index) {
                        final tasks = value.isNow
                            ? value.todosNow
                            : value.todos;
                        final task = tasks[index];
                        return ListTile(
                          leading: Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: task.completed,
                              onChanged: (newValue) {
                                value.checkTodo(task);
                              },
                            ),
                          ),

                          title: Text(
                            task.title,
                            style: TextStyle(
                              color: !task.completed ? Colors.white : Colors.white54,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: Colors.white
                            ),
                          ),

                          trailing: PopupMenuButton<String>(
                            onSelected: (opt) {
                              // handle menu selection here
                              if (opt == 'delete') {
                                value.deleteTodo(task);
                              } else if (opt == 'toNow') {
                                value.addToNow(task);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text(AppLocalizations.of(context)!.delete),
                                ),
                                PopupMenuItem(
                                  value: 'toNow',
                                  child: Text(AppLocalizations.of(context)!.addToNow),
                                ),
                              ];
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
