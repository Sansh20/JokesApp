import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class IconTile extends StatelessWidget{
  final IconData icon;
  final String desc;
  final TextStyle descStyle;
  IconTile({@required this.icon, @required this.desc, this.descStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38,
            blurRadius: 2.0, 
            spreadRadius: 2.0, 
            offset: Offset(0.0, 0.0),
          )
        ],
        color: Color.fromRGBO(16, 19, 21, 1.0),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: InkWell(
        onTap: () => _apiRedirect(),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[700], size: 35,),
            Padding(padding: const EdgeInsets.only(top:18)),
            Text(desc, style: descStyle),
          ],
        ),
      ),
    );
  }
  _apiRedirect() async {
  const url = 'https://sv443.net/jokeapi/v2';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

class ImageTile extends StatelessWidget{
  final String imageSrc;
  final String desc;
  final TextStyle descStyle;
  ImageTile({@required this.imageSrc, @required this.desc, this.descStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38,
            blurRadius: 2.0, 
            spreadRadius: 2.0, 
            offset: Offset(0.0, 0.0),
            
          )
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(imageSrc))
      ),
      child: InkWell(
        onTap: () => _gitRedirect(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              color: Color.fromRGBO(16, 19, 21, 0.99),
            ),
            child: Text(desc, style: descStyle, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
  _gitRedirect() async{
    const url = 'https://github.com/Sv443';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }
}
