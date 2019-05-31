import 'dart:async';

import 'package:pmc_student/core/models/project.dart';
import 'package:pmc_student/core/services/project_service.dart';
import 'package:pmc_student/core/viewmodels/base_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';

class HomeModel extends BaseModel {
  final ProjectService _projectService;

  StreamSubscription _projectsSubscription;

  List<Project> projects;

  HomeModel(this._projectService);

  Future getProjects(String userId) async {
    setState(ViewState.BUSY);

    _projectsSubscription =
        _projectService.getProjectsStream(userId).listen((projects) {
      setState(ViewState.IDLE);

      this.projects = projects ?? List();
    });
  }

  Future createProject(String userId, String name, String description) async {
    setState(ViewState.BUSY);

    await _projectService.createProject(userId, name, description);

    setState(ViewState.IDLE);
  }

  Future deleteProject(String userId, String projectId) async {
    setState(ViewState.BUSY);

    await _projectService.deleteProject(userId, projectId);

    setState(ViewState.IDLE);
  }

  @override
  void dispose() {
    if (_projectsSubscription != null) {
      _projectsSubscription.cancel();
    }

    super.dispose();
  }
}
