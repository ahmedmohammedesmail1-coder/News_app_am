import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_am/core/network/remote/dio_helper.dart';
import 'package:news_app_am/core/theme/theme.dart';
import 'package:news_app_am/core/util/constans/routes.dart';
import 'package:news_app_am/features/home/presentation/logic/home_cubit.dart';


void main()
{
  DioHelper.init();
  runApp(const TaskApp());
}
class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routesApp,
        theme: ThemeAppManager.lightTheme,
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}