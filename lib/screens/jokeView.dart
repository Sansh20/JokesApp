import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class JokeView extends StatefulWidget {
  @override
  _JokeViewState createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  bool autoPlay=true;
  List<Joke> respList = [];
  double i = 0;
  TextStyle textStyle = TextStyle(color: Colors.amber[900], fontWeight: FontWeight.bold, fontSize: 20.0);
  Future fetchJoke() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String categs = prefs.getString('categs');
    String filts = prefs.getString('filters');
    var responseObj;
    for (int i=0; i<=5; i++) {
      final response= await http.get('https://sv443.net/jokeapi/v2/joke/$categs$filts');
      responseObj = Joke.fromJson(json.decode(response.body));
      setState(()=>respList.add(responseObj));
      print(responseObj);
    }
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

  playPause(){
    if(autoPlay){
      return Icon(Icons.pause, color: Colors.blue, size: 35,);
    }
    else{
      return Icon(Icons.play_arrow, color: Colors.blue, size: 35);
    }
  }

  void initState(){
    super.initState();
    fetchJoke();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Swiper(
            itemCount: respList.length,
            itemBuilder: (context, index) {
              return jokes.toList()[index];
            },
            autoplay: autoPlay,
            autoplayDelay: 5000,
            scrollDirection: Axis.horizontal,
            itemWidth: 270,
            itemHeight: 350,
            fade: 50.0,
            index: 1,
            loop: true,
            layout: SwiperLayout.STACK,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: AnimatedSwitcher(duration: Duration(milliseconds: 800), child: playPause(),),
                onPressed: (){
                  if(autoPlay){
                    setState(() {
                      autoPlay=false;
                    });
                  }
                  else setState(() {
                    autoPlay=true;
                  });
                },
              )
            ]
          )
        ],
      ),
    );
  }
  Iterable<Widget> get jokes sync*{
    for(var jokeObj in respList){
      yield Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38,
              blurRadius: 1.0, 
              spreadRadius: 0.0, 
              offset: Offset(-3.0, 0),
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
                  Text(jokeObj.category+' #${jokeObj.id}', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),),
                  jokeObj.type=='single'? Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Text(jokeObj.joke, style: textStyle,),
                  ):Padding(
                    padding: const EdgeInsets.only(top: 50), 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jokeObj.setup, style: textStyle),
                        Padding(padding: const EdgeInsets.only(top:10)),
                        Text(jokeObj.delivery, style: textStyle,),
                      ]
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getFlagTags(jokeObj.flags.nsfw, 'NSFW'),
                        getFlagTags(jokeObj.flags.religious, 'Religious'),
                        getFlagTags(jokeObj.flags.political, 'Political'),
                        getFlagTags(jokeObj.flags.racist, 'Racist'),
                        getFlagTags(jokeObj.flags.sexist, 'Sexist'),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Opacity(opacity: 0.35, child: Text('JokesApp', style: TextStyle(fontSize: 20, color: Color.fromRGBO(7, 27, 55, 1.0), fontWeight: FontWeight.bold),),)
                  )
                ],
              ),
            ),
          ],
        ),
      );
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
  Joke({this.category, this.type, this.joke, this.setup, this.delivery, this.id, this.flags, this.error});
  final String category;
  final String type;
  final String joke;
  final String setup;
  final String delivery;
  final int id;
  Flags flags;
  final bool error;
  factory Joke.fromJson(Map<dynamic, dynamic> json){
    return Joke(
      category: json["category"],
      id: json["id"],
      type: json["type"],
      joke: json["joke"],
      setup: json["setup"],
      delivery: json["delivery"],
      flags : Flags.fromJson(json["flags"]),
      error: json["error"],
    );
  }
}