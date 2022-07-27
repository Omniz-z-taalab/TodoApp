import 'package:flutter/material.dart';

abstract class TodoStates {}
class InitialStates extends TodoStates{}
class TodoDatabaseInitialized extends TodoStates{}
class TodoCreateDatabaseStates extends TodoStates{}
class TodoInsertDatabaseStates extends TodoStates{}
class UsersDataFetchedStates extends TodoStates{}
class TodoChangeColorStates extends TodoStates{}
class TodoGetDatabaseStates extends TodoStates{}
class AppGetDatabaseLoadingState extends TodoStates{}
class AppUpdateDatabaseState extends TodoStates{}
class DeleteDatabaseState extends TodoStates{}
class CheckBoxState extends TodoStates{}
