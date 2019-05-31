import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/project.dart';

class ProjectListItem extends StatelessWidget {
  final Project project;
  final Function onTap;

  const ProjectListItem({this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 60.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                project.name,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
              ),
              Text(project.description,
                  maxLines: 2, overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
      ),
    );
  }
}
