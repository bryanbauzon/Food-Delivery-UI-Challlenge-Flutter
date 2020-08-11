import 'package:flutter/material.dart';

class AppUtil{
  AppUtil();
  showSnackBarByScaffoldKey(String content, GlobalKey<ScaffoldState> scaffoldKey){
      final snackbar = SnackBar(content: Text(content));
      scaffoldKey.currentState.showSnackBar(snackbar);
  }
  getTotal(double price, int quantity){
    return (price * quantity);
  }
  convertDoubleToString(double value){
      return value.toString();
  }
}