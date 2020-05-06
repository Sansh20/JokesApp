import 'dart:async';
import 'package:darkjokes/services/prefs.dart';
import 'package:flutter/material.dart';

class ChoosePrefs extends StatefulWidget {
  bool _isSelected = false;
  @override
  _ChoosePrefsState createState() => _ChoosePrefsState();
}

class _ChoosePrefsState extends State<ChoosePrefs> {
  bool allSel = true;
  bool cusSel = false;
  bool _visible = false;
  double hei = 180;
  String categString;
  String filter = '';
  TextStyle choStyle= TextStyle(fontSize: 27, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.white);
  TextStyle filtStyle= TextStyle(fontSize: 15, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.white);
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
  List<String> _chips = <String>[];
  setCategString(){
    setState(() {
      categString=_chips.join(',');
    });
    print(categString);
  }
  @override
  Widget build(BuildContext context) {
  var screenSize =  MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.center,
              colors: [Color(0xfff1F0D44), Color(0xfff020815)]
            ),
          ),
          child: Column(
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
                    Padding(padding: const EdgeInsets.only(top:20)),  
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
                              categString='Any';
                              if(cusSel = true){
                                cusSel= false;
                                _visible= false;
                                hei = 153;
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
                              hei = 230;
                              cusSel=selected;
                              if(cusSel==false){
                                hei=153;
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
                      duration: Duration(milliseconds: 800),
                      opacity: _visible? 1.0:0.0,
                      child: _visible ? 
                      Wrap(
                        spacing: 5,
                        children: categChips.toList(),
                      ) : Text(''),
                    ),
                  ]
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                height: 250,
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
                  ]
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: ()=> setCategString(),
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
        backgroundColor: Color.fromRGBO(12, 66, 59, 1.0),
        selectedColor: Color.fromRGBO(36, 58, 114, 1.0),
        selected: _chips.contains(categ.categs),
        onSelected: (bool selected){
          setState(() {
            if(selected){
              _chips.add(categ.categs);
            }
            else{
              _chips.removeWhere((String delete) {
                return delete == categ.categs;
              });
            }
          });
        },

      );
    }
  }
  
  Widget filtersPrefs(){
    return Wrap(
        spacing: 10,
        children: [
          FilterChip(
            backgroundColor: Color(0xff020815),
            label: Text('NSFW'),
            labelStyle: filtStyle,
            selected: widget._isSelected,
            onSelected: (bool selected) {
              setState(() => widget._isSelected = selected);
            }
          ),
          FilterChip(
            backgroundColor: Color(0xff020815),
            label: Text('Religious'),
            labelStyle: filtStyle,
            selected: widget._isSelected,
            onSelected: (bool selected) {
              setState(()=> widget._isSelected = selected);
                
              },
            ),
            FilterChip(
              backgroundColor: Color(0xff020815),
              label: Text('Political'),
              labelStyle: filtStyle,
              selected: widget._isSelected,
              onSelected: (bool selected) {
                setState(()=> widget._isSelected = selected);
                  
              },
            ),
            FilterChip(
              backgroundColor: Color(0xff020815),
              label: Text('Sexist'),
              labelStyle: filtStyle,
              selected: widget._isSelected,
              onSelected: (bool selected) {
                setState(()=> widget._isSelected = selected);
                  
                },
            ),
            FilterChip(
              backgroundColor: Color(0xff020815),
              label: Text('Racist'),
              labelStyle: filtStyle,
              selected: widget._isSelected,
              onSelected: (bool selected) {
                setState(()=> widget._isSelected = selected);
                  
                },
            ),
          ]
        );
  }
}

class Categories{
  const Categories(this.categs);
  final String categs;
}