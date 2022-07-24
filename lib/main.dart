import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/Cubit/blocObserver/BlocObserver.dart';

import 'features/presentation/pages/BoardScreen/MyBoardPage.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TodoBloc()..initialDatabase())
        ],
        child: BlocConsumer<TodoBloc, TodoStates>(
            listener: (BuildContext context, Object? state) {},
            builder: (BuildContext context, state) {
             return MaterialApp(
               debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                home: MyBoardPage(),
              );
            }
            ),);
  }
}
