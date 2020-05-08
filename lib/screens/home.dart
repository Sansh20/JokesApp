import 'package:flutter/material.dart';
import 'package:darkjokes/services/prefs.dart';
import 'package:darkjokes/screens/jokeView.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.center,
              colors: [Color(0xfff1F0D44), Color.fromRGBO(7, 24, 45, 1.0)]
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(child: Container(child: Text('Home', style: TextStyle(fontFamily:'Montserrat', fontSize:40, fontWeight: FontWeight.w600, color: Color(0xfff0099FF)),))),
              RaisedButton(
                child: Text('Reset'),
                onPressed:() => Preferences().resetPrefs(),
              ),
              Container(
                child: JokeView()
              ),
            ],
          ),
      ),
    );
  }
}
