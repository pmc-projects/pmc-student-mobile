import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/project.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/widgets/todos.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatelessWidget {
  final Project project;

  const ProjectView({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(project.name, style: headerStyle),
            UIHelper.verticalSpaceMedium(),
            Text(project.description),
            Todos(user.id, project.id),
          ],
        ),
      ),
    );
  }
}
