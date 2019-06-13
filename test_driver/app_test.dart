import 'dart:math';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('PMC', () {
    final userEmail =
        'demo' + Random().nextInt(10000).toString() + '@pmc.edu.rs';

    final loginTitleFinder = find.byValueKey('loginTitle');
    final emailInputFinder = find.byValueKey('email');
    final passInputFinder = find.byValueKey('password');
    final loginButton = find.byValueKey('login');
    final switchButton = find.byValueKey('switch');

    final titleFinder = find.byValueKey('title');
    final btnAddProject = find.byValueKey('addProject');

    final inProjectName = find.byValueKey('projectName');
    final inProjectDesc = find.byValueKey('projectDescription');
    final btnCreateProject = find.byValueKey('projectCreate');

    final projectItemFinder = find.byType("ProjectListItem");
    final projectTitle = find.byValueKey("projectTitle");

    final btnAddTodo = find.byValueKey('addTodo');

    final inTodoName = find.byValueKey('todoName');
    final inTodoDesc = find.byValueKey('todoDescription');
    final btnCreateTodo = find.byValueKey('todoCreate');

    final todoItemFinder = find.byType("TodoItem");

    final btnDeleteProject = find.byValueKey('deleteProject');
    final btnLogout = find.byValueKey('logout');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('student moze da se zapocne registraciju', () async {
      final loginText = await driver.getText(loginTitleFinder);
      if (loginText != 'Registracija') {
        await driver.tap(switchButton);
      }

      expect(await driver.getText(loginTitleFinder), 'Registracija');
    });

    test('student moze da unese svoje kredencijale', () async {
      await driver.tap(emailInputFinder);
      await driver.enterText(userEmail);
      await driver.tap(passInputFinder);
      await driver.enterText('pmcdemo');
    });

    test('student moze da se registruje', () async {
      await driver.tap(loginButton);

      expect(await driver.getText(titleFinder), "PMC Student");
    });

    test('student moze da doda premet', () async {
      await driver.tap(btnAddProject);

      await driver.tap(inProjectName);
      await driver.enterText('Test Predmet #1');

      await driver.tap(inProjectDesc);
      await driver.enterText('Test opis predmeta');

      await driver.tap(btnCreateProject);
    });

    test('student moze da otvori predmet', () async {
      await driver.waitFor(projectItemFinder);

      await driver.tap(projectItemFinder);

      expect(await driver.getText(projectTitle), "Test Predmet #1");
    });

    test('student moze da doda novi zadatak', () async {
      await driver.tap(btnAddTodo);

      await driver.tap(inTodoName);
      await driver.enterText('Test Zadatak');

      await driver.tap(inTodoDesc);
      await driver.enterText('Test opis zadatka');

      await driver.tap(btnCreateTodo);
    });

    test('student moze da odradi zadatak', () async {
      await driver.waitFor(todoItemFinder);

      await driver.tap(todoItemFinder);
    });

    test('student moze da obrise predmet', () async {
      await driver.tap(btnDeleteProject);

      await driver.waitFor(titleFinder);
    });

    test('student moze da doda drugi predmet', () async {
      await driver.tap(btnAddProject);

      await driver.tap(inProjectName);
      await driver.enterText('Drugi predment');

      await driver.tap(inProjectDesc);
      await driver.enterText('Drugi predment u semestru');

      await driver.tap(btnCreateProject);
    });

    test('student moze da se izloguje', () async {
      await driver.tap(btnLogout);

      await driver.waitFor(loginTitleFinder);

      expect(await driver.getText(loginTitleFinder), "Prijava");
    });

    test('student moze da se uloguje', () async {
      await driver.tap(emailInputFinder);
      await driver.enterText(userEmail);
      await driver.tap(passInputFinder);
      await driver.enterText('pmcdemo');

      await driver.tap(loginButton);
    });

    test('student moze da vidi postojeci projekat', () async {
      expect(await driver.getText(titleFinder), "PMC Student");
    });
  });
}
