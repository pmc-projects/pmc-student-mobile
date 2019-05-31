import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/project.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/viewmodels/home_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/views/base_view.dart';
import 'package:pmc_student/ui/widgets/logout_button.dart';
import 'package:pmc_student/ui/widgets/project_list_item.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      disposable: true,
      onModelReady: (model) {
        var user = Provider.of<User>(context);
        if (user == null) {
          return;
        }

        model.getProjects(user.id);
      },
      builder: (context, model, child) {
        final user = Provider.of<User>(context);
        if (user == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: model.state == ViewState.IDLE
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceLarge(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'PMC Student',
                              style: headerStyle,
                            ),
                          ),
                        ),
                        LogoutButton(),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Izaberite predmet za koji želite da pregledate obaveze.',
                        style: subHeaderStyle,
                      ),
                    ),
                    UIHelper.verticalSpaceLarge(),
                    Expanded(child: getProjectsUi(model.projects)),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
            elevation: 15.0,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, 'project/create');
            },
          ),
        );
      },
    );
  }

  Widget getProjectsUi(List<Project> projects) => projects.length > 0
      ? ListView.builder(
          padding: EdgeInsets.only(bottom: 80.0),
          itemCount: projects.length,
          itemBuilder: (context, index) => ProjectListItem(
                project: projects[index],
                onTap: () {
                  Navigator.pushNamed(context, 'project',
                      arguments: projects[index]);
                },
              ))
      : Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Niste uneli ni jedan predmet. Da biste dodali novi predmet, pritisnite dubme za kreiranje novog projekta u donjem desnom uglu.',
            style: TextStyle(),
          ),
        );
}
