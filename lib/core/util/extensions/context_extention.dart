import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void push<ARG>(String routeName, {ARG? argument}) =>
      Navigator.pushNamed(this, routeName, arguments: argument);

  get pop => Navigator.pop(this);
}
