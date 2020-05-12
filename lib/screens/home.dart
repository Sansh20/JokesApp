import 'package:darkjokes/screens/choosePref.dart';
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
          color: Color.fromRGBO(7, 24, 45, 1.0),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text('Home', style: TextStyle(fontFamily:'Montserrat', fontSize:50, fontWeight: FontWeight.w600, color: Colors.orange[900]),)),
                      Tooltip(
                        message: 'Change Preferences',
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        waitDuration: Duration(milliseconds: 200),
                        child: IconButton(
                            icon: Icon(Icons.tune),
                            color: Colors.orangeAccent[700],
                            iconSize: 28,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChoosePrefs(),));
                            },
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: RaisedButton(
                  child: Text('Reset'),
                  onPressed:() => Preferences().resetPrefs(),
                ),
              ),
              Center(
                child: Container(
                  width: screenSize.width,
                  height: 400,
                  child: JokeView(),
                ),
              ),
              Center(child: Text('Tip: If you feel the joke is \nincomplete, try scrolling on the joke!', style: TextStyle(color: Colors.blueAccent))),
              Container(
                child: DraggableScrollableSheet(
                  builder: (context, controller){
                    return ;
                  }
                )
              )
            ],
          ),
      ),
    );
  }
}
