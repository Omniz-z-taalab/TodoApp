import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/util/Cubit/Bloc.dart';
import 'package:untitled/core/util/Cubit/TodoStates.dart';
import 'package:untitled/features/presentation/widgets/buildTaskItemWidget/ItemFavorite.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({Key? key}) : super(key: key);

  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TodoBloc, TodoStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = TodoBloc.get(context).favoritesTasks;
        return Column(
            children:[ Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    favoritesTasks(cubit[index], context),
                separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Colors.white,
                ),
                itemCount: cubit.length,

              ),

            ),

            ]);
      },

    );
  }}
