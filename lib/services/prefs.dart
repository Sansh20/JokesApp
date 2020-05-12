import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:darkjokes/screens/choosePref.dart';
import 'package:darkjokes/screens/home.dart';


class Preferences{
  Widget showPrefs(){
    return FutureBuilder(
      future: checkPrefs(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          if(snapshot.data){
            return WillPopScope(
              onWillPop: () async => false,
              child: Home(),
            );
          }
          else{
            return ChoosePrefs();
          }
        }
        else return Text('Loading');
      } 
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