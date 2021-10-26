import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Weather extends StatefulWidget {

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  var temp;
  var des;
  var hum;
  var wind;

  Future getWeather()async{
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Dhaka&appid=3294ac3ce620b262040a16ba2a1d2f9b");
    var result =jsonDecode(response.body);

    setState(() {

      this.temp = result["main"] ["temp"];
      this.des = result["weather"] [0] ["main"];
      this.hum = result["main"] ["humidity"];
      this.wind = result["wind"] ["speed"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(height: 30,),

            Text("Currently Weather in Dhaka"),
            SizedBox(height: 10,),
            Text(temp !=null ? temp.toString()+"\u00B0": "Loading"),
            SizedBox(height: 10,),
            Text(des!=null ?  des.toString() : "loading"),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Temperature"),
                SizedBox(width: 50,),
                Text(temp !=null ? temp.toString()+"\u00B0": "Loading"),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Weather"),
                SizedBox(width: 78,),
                Text(des !=null ? des.toString() : "Loading"),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Humidity"),
                SizedBox(width: 95,),
                Text(hum !=null ? hum.toString() : "Loading"),
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wind Speed"),
                SizedBox(width: 72,),
                Text(wind !=null ? wind.toString(): "Loading"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
