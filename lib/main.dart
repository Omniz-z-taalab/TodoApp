import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/core/util/Cubit/blocObserver/BlocObserver.dart';
import 'package:untitled/core/util/const/notificationServices.dart';

import 'core/util/NetWork/local/cache_helper.dart';
import 'features/presentation/pages/BoardScreen/MyBoardPage.dart';
import 'features/presentation/pages/SplashScreen/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  Bloc.observer = MyBlocObserver();
 await CacheHelper.init();
 bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  late final bool isDark;
MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc()..initialDatabase()),
        BlocProvider(create: (context) => TodoBloc()..changeMode(
          fromShared: isDark,
        ))

      ],
      child: BlocConsumer<TodoBloc, TodoStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.green,
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20,
                      color: Colors.white,
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarBrightness: Brightness.light,
                        // statusBarIconBrightness: Brightness.light,
                      ),
                      centerTitle: false,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      textTheme: TextTheme(
                        body1: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      iconTheme: IconThemeData(color: Colors.black)),
                  textTheme: TextTheme(
                      title: TextStyle(
                        color: Colors.black,
                      ),
                      subhead: TextStyle(
                        color: Colors.black,
                      ),
                      body2: TextStyle(
                        color: Colors.white,
                      )),
                  backgroundColor: Colors.grey[200],
                  canvasColor: Colors.black,
                  cardColor: Colors.white,
                  indicatorColor: Colors.white
              ),
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  primarySwatch: Colors.green,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    centerTitle: false,
                    color: HexColor('333739'),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarBrightness: Brightness.light,
                      // statusBarIconBrightness: Brightness.light,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textTheme: TextTheme(
                      body1: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                  textTheme: TextTheme(
                      title: TextStyle(
                        color: Colors.white,
                      ),
                      subhead: TextStyle(
                        color: Colors.black,
                      ),
                      body2: TextStyle(
                        color: Colors.white,
                      )),
                  backgroundColor: Colors.grey[600],
                  canvasColor: Colors.white,
                  cardColor: Colors.black),
              themeMode: TodoBloc.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SplashScreen(),
            );
          }),
    );
  }
}
