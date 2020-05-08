import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:darkjokes/screens/choosePref.dart';
import 'package:darkjokes/screens/home.dart';

class Preferences{
  String categs, filts;
  Widget showPrefs(){
    return FutureBuilder(
      future: checkPrefs(),
      builder: (BuildContext context, snapshot){
        if(snapshot.data){
          return Home();
        }
        else{
          return ChoosePrefs();
        }
      },
    );
  }

  checkPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categs = prefs.getString('categs');
    String filters = prefs.getString('filters');
    if(categs==null || filters==null){
      return false;
    }
    else{
      return true;
    }
  }
  setPrefs(String categ, String filter) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('categs', categ);
    prefs.setString('filters', filter);
  }
  resetPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('categs');
    prefs.remove('filters');
  }
}