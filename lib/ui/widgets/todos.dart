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
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView(
                children: model.todos.map((todo) => TodoItem(todo)).toList(),
              )));
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem(this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            todo.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall(),
          Text(todo.description),
        ],
      ),
    );
  }
}
