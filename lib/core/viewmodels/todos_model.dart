import 'dart:async';

import 'package:pmc_student/core/models/todo.dart';
import 'package:pmc_student/core/services/todo_service.dart';
import 'package:pmc_student/core/viewmodels/base_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';

class TodosModel extends BaseModel {
  final TodoService _todoService;

  StreamSubscription _todosSubscription;

  List<Todo> todos;

  TodosModel(this._todoService);

  Future fetchTodos(String userId, String projectId) async {
    setState(ViewState.BUSY);

    _todosSubscription =
        _todoService.getTodosStream(userId, projectId).listen((todos) {
      setState(ViewState.IDLE);

      this.todos = todos ?? List();
    });
  }

  Future toggleTodo(String userId, String projectId, Todo todo) async {
    await _todoService.toggleTodo(userId, projectId, todo.id, !todo.done);
  }

  Future createTodo(
      String userId, String projectId, String title, String description) async {
    setState(ViewState.BUSY);

    await _todoService.createTodo(userId, projectId, title, description);

    setState(ViewState.IDLE);
  }

  Future deleteTodo(String userId, String projectId, String todoId) async {
    await _todoService.deleteTodo(userId, projectId, todoId);
  }

  @override
  void dispose() {
    if (_todosSubscription != null) {
      _todosSubscription.cancel();
    }

    super.dispose();
  }
}
