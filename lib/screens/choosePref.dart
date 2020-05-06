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
  bool prog = false;
  bool dark = false;
  bool mis = false; 
  double hei = 180;
  String categ = '';
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
  void setCateg(String choice){
    setState(() {
      if(choice=='Any'){
        dark=false;
        mis=false;
        prog=false;
        categ=choice;
        print(categ);
      }
      else{
        if(categ.isEmpty || categ=='Any'){
          categ = choice;
          print(categ);
        }
        else if(categ.contains(','+choice)){
          categ = categ.replaceAll(','+choice, '');
          print(categ);
        }
        else if(categ.contains(choice)){
          if(categ.contains(choice+',')) {
            categ = categ.replaceAll(choice+',', '');
          }
          else{
            categ = categ.replaceAll(choice, '');
          }
          print(categ);
        }
        else{
          categ= categ + ',' +choice;
          print(categ);
        }
      }
    });
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
                              setCateg('Any');
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
                              hei = 250;
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
                    Padding(padding: const EdgeInsets.only(top:8)),
                  
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      opacity: _visible? 1.0:0.0,
                      child: categsPrefs(_visible),
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
                    Padding(padding: const EdgeInsets.only(top:20)),  
                    Wrap(
                      spacing: 20.0,
                      children: [
                        ChoiceChip(
                          label: Text('None'), 
                          backgroundColor: Color.fromRGBO(0, 163, 255, 1.0),
                          elevation: 15.0,
                          pressElevation: 0.0,
                          shadowColor: Colors.black,
                          labelStyle: choStyle,
                          selected: allSel,     
                          onSelected: (bool selected) {
                            setState(() {
                              allSel=selected;
                              setCateg('Any');
                            });
                          },
                          selectedColor: Color.fromRGBO(24, 40, 80, 1.0),
                        ),
                        
                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(top:8)),
                  
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      opacity: 1.0,
                      child: filtersPrefs(),
                    ),
                  ]
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: ()=> print('Pressed'),
              )
            ],
          ),
      ),
    );
  }
  Widget categsPrefs(bool show){
    if(show==true){
      return
        Wrap(
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:40.0),
              child: FilterChip(
                backgroundColor: Color(0xff020815),
                label: Text('Dark'),
                labelStyle: filtStyle,
                selected: prog,
                onSelected: (bool selected) {
                  setState(() => prog = selected);
                  setCateg('Dark');
                }
              ),
            ),
            FilterChip(
              backgroundColor: Color(0xff020815),
              label: Text('Programming'),
              labelStyle: filtStyle,
              selected: dark,
              onSelected: (bool selected) {
                setState(()=> dark = selected);
                setCateg('Programming');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left:50.0),
                child: FilterChip(
                  backgroundColor: Color(0xff020815),
                  label: Text('Miscellaneous'),
                  labelStyle: filtStyle,
                  selected: mis,
                  onSelected: (bool selected) {
                    setState(()=> mis = selected);
                    setCateg('Miscellaneous');
                  },
                ),
              ),
            ]
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