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
          : model.todos.length > 0
              ? Expanded(
                  child: ListView(
                      padding: EdgeInsets.zero,
                      children: model.todos
                          .map((todo) => TodoItem(todo,
                              onToggle: (todo) =>
                                  model.toggleTodo(userId, projectId, todo),
                              onDelete: (todo) =>
                                  model.deleteTodo(userId, projectId, todo.id)))
                          .toList()))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Nemate ni jedan zadatak za odabrani predment. Da biste kreirali novi zadatak, pritisnite dugme za kreiranje novih zadataka u donjem desnom uglu.',
                    style: TextStyle(),
                  ),
                ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo todo) onToggle;
  final Function(Todo todo) onDelete;

  const TodoItem(this.todo, {this.onToggle, this.onDelete});

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
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Brisanje zadatka'),
                  content: Text(
                      'Da li ste sigurni da želite da obrišete odabrani zadatak?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ne'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    MaterialButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Text('Da'),
                      onPressed: () {
                        if (onDelete != null) {
                          onDelete(todo);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
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
                  Checkbox(
                      onChanged: (bool value) {
                        if (onToggle != null) {
                          onToggle(todo);
                        }
                      },
                      value: todo.done)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
