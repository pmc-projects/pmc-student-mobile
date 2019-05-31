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

  Future fetchTodos(String accountId, String projectId) async {
    setState(ViewState.BUSY);

    _todosSubscription =
        _todoService.getTodosStream(accountId, projectId).listen((todos) {
      setState(ViewState.IDLE);

      this.todos = todos ?? List();
    });
  }

  @override
  void dispose() {
    if (_todosSubscription != null) {
      _todosSubscription.cancel();
    }

    super.dispose();
  }
}
