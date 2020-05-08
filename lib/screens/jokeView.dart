import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JokeView extends StatefulWidget {
  @override
  _JokeViewState createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  Future<Joke> fetchJoke() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categs = prefs.getString('categs');
    String filts = prefs.getString('filters');
    final response= await http.get('https://sv443.net/jokeapi/v2/joke/$categs$filts');
    print(categs);
    print(filts);
    print(response.body);
    return Joke.fromJson(json.decode(response.body));
  }
  getFlagTags(bool showTag, String title){
    if(showTag){
      return AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 163, 255, 0.75),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(title, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        ),
      );
    }
    else{
      return Text('');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Color(0xfff0099FF),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: fetchJoke(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snapshot.data.category+' #${snapshot.data.id}', style: textStyle,),
                  snapshot.data.type=='single'? Center(
                    child: Text(snapshot.data.joke, style: textStyle,)
                    ): Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(snapshot.data.setup, style: textStyle,),
                        Text(snapshot.data.delivery, style: textStyle,),
                      ]
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getFlagTags(snapshot.data.flags.nsfw, 'NSFW'),
                        getFlagTags(snapshot.data.flags.religious, 'Religious'),
                        getFlagTags(snapshot.data.flags.political, 'Political'),
                        getFlagTags(snapshot.data.flags.racist, 'Racist'),
                        getFlagTags(snapshot.data.flags.sexist, 'Sexist'),
                      ],
                    ),
                  )
                ],
              );
            }
            else{
              return CircularProgressIndicator(
                semanticsLabel: 'Please Wait',
                backgroundColor: Colors.amber,
              );
            }
            
          }
        ),
      )
    );
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