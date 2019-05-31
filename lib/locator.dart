import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pmc_student/core/services/authentication_service.dart';
import 'package:pmc_student/core/services/project_service.dart';
import 'package:pmc_student/core/services/todo_service.dart';
import 'package:pmc_student/core/viewmodels/home_model.dart';
import 'package:pmc_student/core/viewmodels/login_model.dart';
import 'package:pmc_student/core/viewmodels/todos_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => Firestore.instance);

  locator.registerLazySingleton<AuthenticationService>(
      () => FirebaseAuthenticationService(locator<FirebaseAuth>()));
  locator.registerLazySingleton<ProjectService>(
      () => FirestoreProjectService(locator<Firestore>()));
  locator.registerLazySingleton<TodoService>(
      () => FirestoreTodoService(locator<Firestore>()));

  locator.registerLazySingleton(
      () => LoginModel(locator<AuthenticationService>()));

  locator.registerFactory(() => HomeModel(locator<ProjectService>()));
  locator.registerFactory(() => TodosModel(locator<TodoService>()));
}
