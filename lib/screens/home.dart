import 'package:darkjokes/screens/choosePref.dart';
import 'package:flutter/material.dart';
import 'package:darkjokes/services/prefs.dart';
import 'package:darkjokes/screens/jokeView.dart';
import 'package:darkjokes/widgets/infoTile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
          body: Stack(
            children: [
              Container(
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
                  Center(child: Text('Tip: If you feel the joke is \n incomplete, try scrolling on the joke!', style: TextStyle(color: Colors.blueAccent))),
                  Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Center(child: Icon(MdiIcons.gestureSwipeUp, size: 40, color: Colors.blue,)),
                  )
                ],
              ),
            ),
            Container(
                child: GestureDetector(
                  onVerticalDragEnd: (details) {
                    print(details.primaryVelocity);
                    if(details.primaryVelocity<0) showModalBottomSheet(
                      enableDrag: true,
                      barrierColor: Color.fromRGBO(0, 0, 0, 0.75),
                      clipBehavior: Clip.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      context: context, 
                      builder: (context) {
                        return Container(
                          height: 380,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 19, 21, 1.0),
                            borderRadius: BorderRadius.circular(28.0)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.drag_handle, size: 30, color: Colors.grey[800],),
                              Text('JokesApp', style: TextStyle(color: Colors.grey[600], fontFamily: 'Varela', fontWeight: FontWeight.w600, fontSize: 28),),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('An implementation of JokeAPI', style: TextStyle(color: Colors.grey[600], fontFamily: 'Montserrat', fontSize: 15)),
                              ),
                              Padding(padding: const EdgeInsets.only(top: 20),),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconTile(
                                    icon: MdiIcons.fileMultiple,
                                    desc: 'API Docs',
                                    descStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Montserrat', fontSize: 15),
                                  ),
                                  ImageTile(
                                    imageSrc: 'https://avatars2.githubusercontent.com/u/38158426?s=400&v=4',
                                    desc: "Sven Fehler's Github",
                                    descStyle: TextStyle(color: Colors.grey[600], fontFamily: 'Montserrat', fontSize: 12,),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 10),
                                child: Text('Developed By Sanyam Sharma', style: TextStyle(color: Colors.grey[600], fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 1))
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(MdiIcons.github, color: Colors.grey[600],),
                                      iconSize: 38,
                                      onPressed: null,
                                    ),
                                    IconButton(
                                      icon: Icon(MdiIcons.instagram, color: Colors.grey[600],),
                                      iconSize: 38,
                                      onPressed: null,
                                    ),
                                    IconButton(
                                      icon: Icon(MdiIcons.email, color: Colors.grey[600],),
                                      iconSize: 38,
                                      onPressed: null,
                                    ),
                                  ],
                                ),
                              )
                            ] 
                          ),
                        );
                      }
                    );
                  },
                )
              )
          ],
        ),
    );
  }
}
