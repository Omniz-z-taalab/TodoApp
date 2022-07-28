import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/const/notificationServices.dart';

class TodoBloc extends Cubit<TodoStates> {
  TodoBloc() : super(InitialStates());

  static TodoBloc get(context) => BlocProvider.of<TodoBloc>(context);
  DateTime selectedDate = DateTime.now();
void ScheduleDate(){
  String dateOfDay = DateFormat('EEEE').format(selectedDate);
  print(dateOfDay.toString());

}
  MaterialColor TaskColor = Colors.green;
  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoritesTasks = [];
  List<Map> tasks = [];
  int? current = 0;

  var colorController = TextEditingController();

  void initialDatabase() async {
    var databasepath = await getDatabasesPath();
    String path = p.join(databasepath, 'users.db');
    emit(TodoDatabaseInitialized());
    openAppDatabase(path: path);
    debugPrint('CreatedDatabaseInitialized');
  }

  late Database database;
var isChecked = false ;
  changeCheckBox(bool? value,int id) {
    isChecked = value!;
    emit(CheckBoxState());
  }

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    print("Taalab:  ${databasesPath}");
    String path = p.join(databasesPath, 'tasks.db');
    debugPrint('Initialize Database');
    openAppDatabase(path: path);
    emit(TodoDatabaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,'
                    ' title TEXT'
                    ', date TEXT'
                    ', startTime TEXT'
                    ', endTime TEXT,'
                    ' remind TEXT,'
                    'status TEXT,'
                    'color TEXT,'
                    'favorite TEXT)')
            .then((value) {
          debugPrint('Table Created');
        }).catchError((error) {
          debugPrint('Error when database created ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        debugPrint('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseStates());
    });
  }

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var remindController = TextEditingController();
  var dayController = TextEditingController();

  void insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String color,

  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,startTime,endTime,remind,status,color,favorite) VALUES ("$title","$date","$startTime","$endTime","$remind","new","$color","new")')
          .then((value) {
        debugPrint('$value Inserting Successfully');

        // NotifyHelper().scheduledNotification(int.parse(startTime.toString()),int.parse(endTime.toString()));
        NotifyHelper().displayNotification(title: title, body: remind);
        titleController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        dayController.clear();

        getDataFromDatabase(database);
        emit(TodoInsertDatabaseStates());
        emit(TodoGetDatabaseStates());
      }).catchError((error) {
        debugPrint('Error when database inserting ${error.toString()}');
      });
    });
  }

  getDataFromDatabase(database) {
    allTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favoritesTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      allTasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          uncompletedTasks.add(element);
        } else if (element['status'] == 'completed') {
          completedTasks.add(element);
        } if(element['favorite'] == 'favorite'){
          favoritesTasks.add(element);
        }
        debugPrint(element.toString());
      });
      emit(TodoGetDatabaseStates());
    });
  }

  upDateFavoriteTasks({
    required String favorite,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET favorite = ? WHERE id = ?',
        ['$favorite', '$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateFavoriteDatabaseState());
    });
  }

   upDateTodoDatabase({
    required String status,
    required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void DeletTodoDatabase({
    required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }
}
