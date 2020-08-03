import 'package:flutter/material.dart';

class AppUtil{
  AppUtil();
  showSnackBarByScaffoldKey(String content, GlobalKey<ScaffoldState> scaffoldKey){
      final snackbar = SnackBar(content: Text(content));
      scaffoldKey.currentState.showSnackBar(snackbar);
  }
}