import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/project.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/viewmodels/home_model.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/views/base_view.dart';
import 'package:pmc_student/ui/widgets/todos.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatelessWidget {
  final Project project;

  const ProjectView({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceLarge(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Text(project.name,
                              style: headerStyle, key: Key("projectTitle"))),
                      IconButton(
                        key: Key("deleteProject"),
                        highlightColor: Colors.deepPurpleAccent,
                        hoverColor: Colors.deepPurpleAccent,
                        splashColor: Colors.deepPurpleAccent,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          model.deleteProject(user.id, project.id);

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Text(project.description),
                  UIHelper.verticalSpaceMedium(),
                  Todos(user.id, project.id),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              key: Key('addTodo'),
              elevation: 15.0,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'todo/create', arguments: project);
              },
            ),
          ),
    );
  }
}
