import 'package:flutter/material.dart';
import 'package:news_app_am/features/home/presentation/screen/home_screen.dart';
import 'package:news_app_am/features/home/presentation/screen/login_screen.dart';

class Routes 
{
  static const String homeScreen='/HomeScreen';
  static const String loginScreen='/LoginScreen';
 static final Map<String,WidgetBuilder>routesApp=
  {
    homeScreen:(context)=> HomeScreen(),
    loginScreen:(context)=>const LoginScreen(),
  };
}