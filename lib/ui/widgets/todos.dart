import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/todo.dart';
import 'package:pmc_student/core/viewmodels/todos_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/views/base_view.dart';

class Todos extends StatelessWidget {
  final String userId;
  final String projectId;

  Todos(this.userId, this.projectId);

  @override
  Widget build(BuildContext context) {
    return BaseView<TodosModel>(
        disposable: true,
        onModelReady: (model) => model.fetchTodos(userId, projectId),
        builder: (context, model, child) => model.state == ViewState.BUSY
            ? Expanded(
          child: Center(child: CircularProgressIndicator()),
        )
            : Expanded(
                child: ListView(
                  children: model.todos
                      .map((todo) =>
                      TodoItem(
                        todo,
                        onToggle: (todo) =>
                            model.toggleTodo(userId, projectId, todo),
                      ))
                      .toList(),
              )));
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo todo) onToggle;

  const TodoItem(this.todo, {this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5.0,
      child: InkWell(
        splashColor: Colors.deepPurpleAccent,
        onTap: () {
          if (onToggle != null) {
            onToggle(todo);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      todo.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(todo.description ?? ''),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Checkbox(onChanged: (bool value) {}, value: todo.done)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
