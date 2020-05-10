import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JokeView extends StatefulWidget {
  @override
  _JokeViewState createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  List<Joke> respList = [];
  double i = 0;
  TextStyle textStyle = TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 20.0);
  Future<List> fetchJoke() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categs = prefs.getString('categs');
    String filts = prefs.getString('filters');
    var responseObj;
    for (int i=0; i<=5; i++) {
      final response= await http.get('https://sv443.net/jokeapi/v2/joke/$categs$filts');
      responseObj = Joke.fromJson(json.decode(response.body));
      respList.add(responseObj);
      print(responseObj);
    }
    return respList;
  }

  getFlagTags(bool showTag, String title){
    if(showTag){
      return AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: 1.0,
        child: Container(
          height: 20,
          padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(7, 27, 55, 1.0),
            borderRadius: BorderRadius.only(topRight: Radius.circular(8.0)),
          ),
          child: Center(child: Text(title, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))),
        ),
      );
    }
    else{
      return Text('');
    }
  }

  void initState(){
    super.initState();
    fetchJoke();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: jokes.toList(),
      ),
    );
  }
  Iterable<Widget> get jokes sync*{
    for(var u in respList){
      yield Container(
      width: 250,
      height: 300,
      //padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38,
            blurRadius: 1.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(3.0, 0),
          )
        ],
        color: Color.fromRGBO(0, 60, 110, 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column( 
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(u.category+' #${u.id}', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),),
                u.type=='single'? Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Text(u.joke, style: textStyle,),
                ):Padding(
                  padding: const EdgeInsets.only(top: 50), 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u.setup, style: textStyle),
                      Padding(padding: const EdgeInsets.only(top:10)),
                      Text(u.delivery, style: textStyle,),
                    ]
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getFlagTags(u.flags.nsfw, 'NSFW'),
                  getFlagTags(u.flags.religious, 'Religious'),
                  getFlagTags(u.flags.political, 'Political'),
                  getFlagTags(u.flags.racist, 'Racist'),
                  getFlagTags(u.flags.sexist, 'Sexist'),
                ],
              ),
            ),
          )
        ],
      ),
        );
      i+=5;
    }
  }
}

class Flags{
  Flags({this.nsfw, this.racist, this.sexist, this.religious, this.political});
  final bool nsfw;
  final bool racist;
  final bool sexist;
  final bool religious;
  final bool political;
  factory Flags.fromJson(Map<dynamic, dynamic> json){
    return Flags(
      nsfw: json["nsfw"],
      religious: json["religious"],
      political: json["political"],
      racist: json["racist"],
      sexist: json["sexist"],
    );
  }
}
class Joke{
  Joke({this.category, this.type, this.joke, this.setup, this.delivery, this.id, this.flags});
  final String category;
  final String type;
  final String joke;
  final String setup;
  final String delivery;
  final int id;
  Flags flags;
  factory Joke.fromJson(Map<dynamic, dynamic> json){
    return Joke(
      category: json["category"],
      id: json["id"],
      type: json["type"],
      joke: json["joke"],
      setup: json["setup"],
      delivery: json["delivery"],
      flags : Flags.fromJson(json["flags"]),
    );
  }
}