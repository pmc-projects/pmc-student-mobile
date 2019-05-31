import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/viewmodels/home_model.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class ProjectCreateView extends StatefulWidget {
  final String validationMessage;
  final bool isLoading;
  final Function(String name, String description) onCreate;

  const ProjectCreateView(
      {Key key, this.validationMessage, this.isLoading = false, this.onCreate})
      : super(key: key);

  @override
  _ProjectCreateViewState createState() => _ProjectCreateViewState();
}

class _ProjectCreateViewState extends State<ProjectCreateView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UIHelper.verticalSpaceLarge(),
                    Text('Novi Predmet', style: headerStyle),
                    UIHelper.verticalSpaceSmall(),
                    Text('Unesite ime i kretak opis željenog predmeta.',
                        style: subHeaderStyle),
                    UIHelper.verticalSpaceMedium(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            height: 50.0,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Ime predmeta'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Unesite ime predmeta.';
                                }
                              },
                              controller: _nameController,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                minLines: 4,
                                maxLines: 100,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Opis predmeta'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Unesite opis predmeta.';
                                  }
                                },
                                controller: _descriptionController,
                              ),
                            ),
                          ),
                          this.widget.validationMessage != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(widget.validationMessage,
                                      style: TextStyle(color: Colors.red)),
                                )
                              : UIHelper.verticalSpaceSmall(),
                          MaterialButton(
                            color: Colors.deepPurple,
                            minWidth: double.infinity,
                            child: widget.isLoading
                                ? SizedBox(
                                    height: 15.0,
                                    width: 15.0,
                                    child: Theme(
                                      data: Theme.of(context)
                                          .copyWith(accentColor: Colors.white),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Napravi Projekat',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }

                              model.createProject(
                                user.id,
                                _nameController.text,
                                _descriptionController.text,
                              );

                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
