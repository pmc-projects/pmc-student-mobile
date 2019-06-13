import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/viewmodels/todos_model.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';
import 'package:pmc_student/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class TodoCreateView extends StatefulWidget {
  final String projectId;
  final String validationMessage;
  final bool isLoading;
  final Function(String name, String description) onCreate;

  const TodoCreateView({
    Key key,
    this.validationMessage,
    this.isLoading = false,
    this.onCreate,
    this.projectId,
  }) : super(key: key);

  @override
  _TodoCreateViewState createState() => _TodoCreateViewState();
}

class _TodoCreateViewState extends State<TodoCreateView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return BaseView<TodosModel>(
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
                    Text('Novi Zadatak', style: headerStyle),
                    UIHelper.verticalSpaceSmall(),
                    Text('Unesite tekst zadatka kao i njegov kratak opis.',
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
                              key: Key("todoName"),
                              decoration:
                              InputDecoration.collapsed(hintText: 'Zadatk'),
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
                                key: Key("todoDescription"),
                                minLines: 4,
                                maxLines: 100,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Opis zadatka'),
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
                            key: Key('todoCreate'),
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
                              'Napravi Zadatak',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }

                              model.createTodo(
                                user.id,
                                widget.projectId,
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
