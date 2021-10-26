import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/weatherpage.dart';



class Languagepage extends StatefulWidget {
  @override
  _LanguagepageState createState() => _LanguagepageState();
}

class _LanguagepageState extends State<Languagepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Select"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    setState(() {
                      EasyLocalization.of(context).locale = Locale("bn", "BN");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Weatherpage()));
                    });
                  },
                  child: Text("বাংলা")),
              FlatButton(
                  color: Colors.blueAccent,
                  onPressed: (){
                    setState(() {
                      EasyLocalization.of(context).locale = Locale("en", "EN");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Weatherpage()));
                    });
                  },
                  child: Text("English")),
              // FlatButton(
              //     color: Colors.blueAccent,
              //     onPressed: (){
              //       setState(() {
              //         Navigator.push(context, MaterialPageRoute(builder: (context) => Weatherpage()));
              //
              //       });
              //     },
              //     child: Text("Weather Information")),
            ],
          )
      ),
    );
  }
}
