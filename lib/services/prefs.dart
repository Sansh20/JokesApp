import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:darkjokes/screens/choosePref.dart';
import 'package:darkjokes/screens/home.dart';

class Preferences{
  checkPrefs(){
    return StreamBuilder(
      stream: SharedPreferences.getInstance().asStream(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.toString()==null){
          return Home();
        }
        else{
          return ChoosePrefs();
        }});}

  setPrefs(String categ, String filter) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('categs', categ);
    prefs.setString('filters', filter);
  }
  getCategs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categs = prefs.getString('categs');
    return categs;
  }
  getFilts() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String filters = prefs.getString('filters');
    return filters;
  }

}