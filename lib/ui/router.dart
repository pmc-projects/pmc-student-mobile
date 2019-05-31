import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/project.dart';
import 'package:pmc_student/ui/views/home_view.dart';
import 'package:pmc_student/ui/views/login_view.dart';
import 'package:pmc_student/ui/views/project_create_view.dart';
import 'package:pmc_student/ui/views/project_view.dart';
import 'package:pmc_student/ui/views/todo_create_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'project':
        var project = settings.arguments as Project;

        return MaterialPageRoute(builder: (_) => ProjectView(project: project));
      case 'project/create':
        return MaterialPageRoute(builder: (_) => ProjectCreateView());
      case 'todo/create':
        var project = settings.arguments as Project;

        return MaterialPageRoute(
            builder: (_) => TodoCreateView(projectId: project.id));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
