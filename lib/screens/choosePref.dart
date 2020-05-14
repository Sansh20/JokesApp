import 'dart:async';
import 'package:darkjokes/services/prefs.dart';
import 'package:flutter/material.dart';

class ChoosePrefs extends StatefulWidget {
  @override
  _ChoosePrefsState createState() => _ChoosePrefsState();
}

class _ChoosePrefsState extends State<ChoosePrefs> {
  bool allSel = true;
  bool cusSel = false;
  bool noneSel = true;
  bool _visible = false;
  double hei = 140;
  String categString;
  String filtString = '';
  TextStyle choStyle= TextStyle(fontSize: 27, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.white);
  TextStyle filtStyle= TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.white);
  void apppearTime(bool selected){
    int timel=0;
    if(selected==false){
      _visible=selected;
    }
    else{
    Timer.periodic(Duration(microseconds: 10000), (Timer timer){
      timel++;
      if(timel==18){
        setState(()=>_visible=true);
        timer.cancel();
      }
    });
    }
  }

  final List<Categories> _categsList = <Categories>[
    const Categories('Dark'),
    const Categories('Programming'),
    const Categories('Miscellaneous'),
  ];

  List<String> _cchips = <String>[];
  setCategString(){
    setState(() {
      if(allSel){
        categString = 'Any';
      }
      else{
        categString=_cchips.join(',');
      }
    });
    print(categString);
  }
  final List<Blacklists> _filtList = <Blacklists>[
    const Blacklists('NSFW'),
    const Blacklists('Sexist'),    
    const Blacklists('Racist'),
    const Blacklists('Religious'),
    const Blacklists('Political'),
  ];
  List<String> _fchips = <String>[];
  setFiltString(){
    setState(() {
      if(noneSel){
        filtString = '';
      }
      else{
        filtString='?blacklistFlags=' +_fchips.join(',');
      }
    });
    print(filtString);
  }
  @override
  Widget build(BuildContext context) {
  var screenSize =  MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
            height: screenSize.height,
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
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Choose Your Preferences', style: TextStyle(fontFamily:'Montserrat', fontSize:40, fontWeight: FontWeight.w600, color: Color(0xfff0099FF)),),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: hei,
                width: screenSize.width/1.07,
                decoration: BoxDecoration(
                  color: Color(0xfff0099FF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Color.fromRGBO(10, 24, 48, 1.0), width: 4.0,),
                      ),
                      child: Text('Types Of Jokes', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Color.fromRGBO(10, 24, 48, 1.0), fontSize: 30),)
                    ),
                    Padding(padding: const EdgeInsets.only(top:10)),  
                    Wrap(
                      spacing: 20.0,
                      children: [
                        ChoiceChip(
                          label: Text('All'), 
                          backgroundColor: Color.fromRGBO(0, 163, 255, 1.0),
                          elevation: 15.0,
                          pressElevation: 0.0,
                          shadowColor: Colors.black,
                          labelStyle: choStyle,
                          selected: allSel,     
                          onSelected: (bool selected) {
                            setState(() {
                              allSel=selected;
                              for(Categories los in _categsList){
                                _cchips.removeWhere((String delete){
                                  return delete == los.categs;
                                });
                              }
                              if(cusSel){
                                cusSel= false;
                                _visible= false;
                                hei = 140;
                              }
                            });
                          },
                          selectedColor: Color.fromRGBO(24, 40, 80, 1.0),
                        ),
                        ChoiceChip(
                          label: Text('Custom'), 
                          backgroundColor: Color.fromRGBO(0, 163, 255, 1.0),
                          elevation: 10.0,
                          pressElevation: 0.0,
                          shadowColor: Colors.black,
                          labelStyle: choStyle,
                          selected: cusSel,     
                          onSelected: (bool selected) {
                            setState(() {
                              hei = 220;
                              cusSel=selected;
                              if(cusSel==false){
                                hei=140;
                                for(Categories los in _categsList){
                                _cchips.removeWhere((String delete){
                                  return delete == los.categs;
                                });
                              }
                            }
                              allSel=!selected;
                              apppearTime(selected);
                            });
                          },
                          selectedColor: Color.fromRGBO(24, 40, 80, 1.0),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(top:3)),
                    /*Divider(
                      endIndent: 20.0,
                      color: Colors.black,
                      )*/
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: _visible? 1.0:0.0,
                      child: _visible ? 
                      Wrap(
                        spacing: 9,
                        children: categChips.toList(),
                      ) : Text(''),
                    ),
                  ]
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: 215,
                width: screenSize.width/1.07,
                decoration: BoxDecoration(
                  color: Color(0xfff0099FF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: Color.fromRGBO(10, 24, 48, 1.0), width: 4.0,),
                      ),
                      child: Text('Filters', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Color.fromRGBO(10, 24, 48, 1.0), fontSize: 30),)
                    ),
                    Padding(padding: const EdgeInsets.only(top:5),),
                    ChoiceChip(
                      label: Text('None'), 
                      backgroundColor: Color.fromRGBO(0, 163, 255, 1.0),
                      elevation: 15.0,
                      pressElevation: 0.0,
                      shadowColor: Colors.black,
                      labelStyle: choStyle,
                      selected: noneSel,     
                      onSelected: (bool selected) {
                        setState(() {
                          noneSel=selected;
                          if(noneSel==true){
                            for(Blacklists polos in _filtList){
                            _fchips.removeWhere((String delete){
                              return delete == polos.filts;
                            });
                          }}
                        });
                      },
                      selectedColor: Color.fromRGBO(24, 40, 80, 1.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Wrap(
                        spacing: 10.0,
                        children: filtChips.toList(),
                      ),
                    )
                  ]
                ),
              ),
              
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment(0.85, -0.75),
                    children: [
                      Container(child: Image.asset('assets/vectors/waves.png', fit: BoxFit.cover,)),
                      FloatingActionButton(
                        child: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          setCategString();
                          setFiltString();
                          if(categString=='' || filtString=='?blacklistFlags=' || filtString==null){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Warning!', style: TextStyle(fontFamily: 'Montserrat', color: Colors.amber, fontWeight: FontWeight.w600,)),
                                  content: Container(
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(color: Color.fromRGBO(10, 24, 48, 1.0), width: 4.0,),
                                    ),
                                    child: Text('Please Select A Category or Just Select "All" and Leave Filters to "None"', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Color.fromRGBO(10, 24, 48, 1.0), fontSize: 20),)
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text('Close'),
                                      color: Color.fromRGBO(36, 58, 114, 1.0),
                                      onPressed: Navigator.of(context).pop,
                                    ),
                                  ],
                                  backgroundColor: Color.fromRGBO(0, 84, 161, 1.0),
                                );
                              }
                            );
                          }
                          else{
                          Preferences().setPrefs(categString, filtString);
                            Navigator.push(context, 
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 200),
                                transitionsBuilder: (BuildContext comtext, Animation<double> animation, Animation<double> secAnimation, Widget child) {
                                  var begin = Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end);
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (context, animation, secAnimation){
                                  return Preferences().showPrefs();
                                },
                              ),
                            );
                          }
                        }
                      ),  
             ]),
                ),
              )
            ],
          ),
      ),
    );
  }

  Iterable<Widget> get categChips sync*{
    for(Categories categ in _categsList){
      yield FilterChip(
        label: Text(categ.categs),
        labelStyle: filtStyle,
        backgroundColor: Color.fromRGBO(0, 84, 161, 1.0),
        selectedColor: Color.fromRGBO(36, 58, 114, 1.0),
        checkmarkColor: Colors.white,
        selected: _cchips.contains(categ.categs),
        onSelected: (bool selected){
          setState(() {
            if(selected){
              _cchips.add(categ.categs);
            }
            
            else{
              _cchips.removeWhere((String delete) {
                return delete == categ.categs;
              });
            }
          });
        },

      );
    }
  }
  Iterable<Widget> get filtChips sync*{
    for(Blacklists filt in _filtList){
      yield FilterChip(
        label: Text(filt.filts), 
        labelStyle: filtStyle,
        backgroundColor: Color.fromRGBO(0, 84, 161, 1.0),
        selectedColor: Color.fromRGBO(36, 58, 114, 1.0),
        checkmarkColor: Colors.white,
        selected: _fchips.contains(filt.filts),
        onSelected: (bool selected){
          setState(() {
            noneSel=false;
            if(selected){
              _fchips.add(filt.filts);
            }
            else{
              _fchips.removeWhere((String delete) {
                return delete == filt.filts;
              });
            }
          });
        }
      );
    }
  }
}

class Categories{
  const Categories(this.categs);
  final String categs;
}

class Blacklists{
  const Blacklists(this.filts);
  final String filts;
}