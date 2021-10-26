import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:flutter/cupertino.dart';

class Weatherpage extends StatefulWidget {
  @override
  _WeatherpageState createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {

  var _temp,
      _description,
      _minitemp,
      _maxtemp,
      _feellike,
      _precipitation,
      _wind,
      _humidity,
      _visibility,
      _pressure,
      _dewpoint,
  // _sunrise,
  // _moonrise,
      _eighttemp,
      _twelvetemp,
      _sixteentemp,
      _twintytemp,
      _moonphase,
      _clouds,
      _foreighticon,
      _fortwelveicon,
      _forsixteenicon,
      _fortwintyicon,
      _dt,
      _location;

  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();

  Future getWeatherInfo() async {
    http.Response _response = await http.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=23.71&lon=90.40&exclude=alerts&units=metric&appid=32511dee4a22469574a36f13f8be3c55");

    var _jsondecode = jsonDecode(_response.body);

    setState(() {
      this._dt = _jsondecode["current"]["dt"];
      this._temp = _jsondecode["current"]["temp"];
      this._description = _jsondecode["current"]["weather"][0]["main"];
      this._minitemp = _jsondecode["daily"][0]["temp"]["min"];
      this._maxtemp = _jsondecode["daily"][0]["temp"]["max"];
      this._feellike = _jsondecode["current"]["feels_like"];
      this._precipitation = _jsondecode["minutely"][0]["precipitation"];
      this._wind = _jsondecode["current"]["wind_speed"];
      this._humidity = _jsondecode["current"]["humidity"];
      this._visibility = _jsondecode["current"]["visibility"];
      this._pressure = _jsondecode["current"]["pressure"];
      this._dewpoint = _jsondecode["current"]["dew_point"];
      // this._sunrise = _jsondecode["current"]["sunrise"];
      // this._moonrise = _jsondecode["daily"][0]["moonrise"];
      this._eighttemp = _jsondecode["hourly"][8]["temp"];
      this._twelvetemp = _jsondecode["hourly"][12]["temp"];
      this._sixteentemp = _jsondecode["hourly"][16]["temp"];
      this._twintytemp = _jsondecode["hourly"][20]["temp"];
      this._location = _jsondecode["timezone"];
      this._clouds = _jsondecode["current"]["clouds"];
      this._moonphase = _jsondecode["daily"][0]["moon_phase"];
      this._foreighticon = _jsondecode["hourly"][8]["weather"][0]["main"];
      this._fortwelveicon = _jsondecode["hourly"][12]["weather"][0]["main"];
      this._forsixteenicon = _jsondecode["hourly"][16]["weather"][0]["main"];
      this._fortwintyicon = _jsondecode["hourly"][20]["weather"][0]["main"];
    });
  }

  changeIcon() {
    if (_description == "Rain" && _dt < _forsixteen) {
      return WeatherIcons.wiDayRainMix;
    } else if (_description == "Clouds" && _dt < _forsixteen) {
      return WeatherIcons.wiDayCloudy;
    } else if (_description == "Clear" && _dt < _forsixteen) {
      return WeatherIcons.wiDaySunny;
    } else if (_description == "Clear" && _dt > _forsixteen) {
      return WeatherIcons.wiNightClear;
    }else if (_description == "Clouds" && _dt > _forsixteen) {
      return WeatherIcons.wiNightCloudy;
    }else if (_description == "Rain" && _dt > _forsixteen) {
      return WeatherIcons.wiNightRainMix;
    }
  }

  changeBg() {
    if (_description == "Rain") {
      return AssetImage('images/rain2.jpg');
    } else if (_description == "Clouds") {
      return AssetImage('images/cloudy1.jpg');
    } else if (_description == "Clear") {
      return AssetImage('images/sunny3.jpg');
    }
  }

  //for today section icon change
  var _foreight = 1622336400,
      _fortwelve = 1622350800,
      _forsixteen = 1622365200,
      _fortwinty = 1622379600;

  changeEightIcon() {
    if (_foreighticon == "Rain" && _foreight == 1622336400) {
      return WeatherIcons.wiDayRain;
    } else if (_foreighticon == "Clouds" && _foreight == 1622336400) {
      return WeatherIcons.wiDayCloudy;
    } else if (_foreighticon == "Clear" && _foreight == 1622336400) {
      return WeatherIcons.wiDaySunny;
    }
  }

  changeTwelveIcon() {
    if (_fortwelveicon == "Rain" && _fortwelve == 1622350800) {
      return WeatherIcons.wiRainMix;
    } else if (_fortwelveicon == "Clouds" && _fortwelve == 1622350800) {
      return WeatherIcons.wiCloudy;
    } else if (_fortwelveicon == "Clear" && _fortwelve == 1622350800) {
      return WeatherIcons.wiDaySunny;
    }
  }

  changeSixteenIcon() {
    if (_forsixteenicon == "Rain" && _forsixteen == 1622365200) {
      return WeatherIcons.wiDayRain;
    } else if (_forsixteenicon == "Clouds" && _forsixteen == 1622365200) {
      return WeatherIcons.wiDayCloudy;
    } else if (_forsixteenicon == "Clear" && _forsixteen == 1622365200) {
      return WeatherIcons.wiSunset;
    }
  }

  changeTwintyIcon() {
    if (_fortwintyicon == "Rain" && _fortwinty == 1622379600) {
      return WeatherIcons.wiNightRainMix;
    } else if (_fortwintyicon == "Clouds" && _fortwinty == 1622379600) {
      return WeatherIcons.wiNightAltCloudy;
    } else if (_fortwintyicon == "Clear" && _fortwinty == 1622379600) {
      return WeatherIcons.wiNightClear;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Information".tr().toString()),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: changeBg(), fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2.5,
                  sigmaY: 2.5,
                ),
                child: Container(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_sharp,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            DateFormat(' H:m').format(_time),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            ' ${_location.toString()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    //end time and location section
                    //start current temp section
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //start icon and temp more section
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white.withOpacity(.2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(-10, 5),
                                      blurRadius: 5,
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  Icon(
                                    changeIcon(),
                                    //WeatherIcons.wiNightAltRainMix,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  Text(
                                    NumberFormat('##').format(_temp) +
                                        "\u00B0C",
                                    // _temp != null
                                    //     ? _temp.toInt().toString() + "\u00B0C"
                                    //     : "N/A",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ),
                                  Text(
                                    _description != null
                                        ? _description.toString()
                                        : "n/a",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(_date),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      //fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          //start more info container
                          Expanded(
                            child: Container(
                              //padding: EdgeInsets.all(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NumberFormat('##').format(_minitemp) +
                                        "\u00B0C - " +
                                        NumberFormat('##').format(_maxtemp) +
                                        "\u00B0C",
                                    // _minitemp.toInt().toString() +
                                    //     "\u00B0C" +
                                    //     " - " +
                                    //     _maxtemp.toInt().toString() +
                                    //     "\u00B0C",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Feels like: ' +
                                        NumberFormat('##').format(_feellike) +
                                        "\u00B0C",
                                    // _feellike.toInt().toString() +
                                    // '\u00B0C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Clouds: '.tr().toString() + _clouds.toString() + "%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Wind: ' +
                                        NumberFormat('##').format(_wind) +
                                        // _wind.toInt().toString() +
                                        "km/h",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Humidity: ' + _humidity.toString() + '%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Visibility: ' +
                                        NumberFormat('##').format(_visibility) +
                                        // _visibility.toString() +
                                        'm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Pressure: ' + _pressure.toString() + 'mb',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Dew Point: ' +
                                        NumberFormat('##').format(_dewpoint) +
                                        //_dewpoint.toInt().toString() +
                                        '%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  // Text(
                                  //   'Sunrise: 5:12am',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 15),
                                  // ),
                                  // Text(
                                  //   'Moonrise: 8:55pm',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 15),
                                  // ),
                                  Text(
                                    'Moon Phase: ${_moonphase.toString()}\u00B0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Precipitation: ' +
                                        _precipitation.toString() +
                                        '%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //end current temp section
                    Spacer(),
                    //start hourly section
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(-10, 5),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      '08:00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Icon(
                                      changeEightIcon(),
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      NumberFormat('##').format(_eighttemp) +
                                          "\u00B0C",
                                      // _eighttemp != null
                                      //     ? _eighttemp.toInt().toString() +
                                      //         "\u00B0C"
                                      //     : "n/a",
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(-10, 5),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      '12:00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Icon(
                                      changeTwelveIcon(),
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      NumberFormat('##').format(_twelvetemp) +
                                          "\u00B0C",
                                      // _twelvetemp != null
                                      //     ? _twelvetemp.toInt().toString() +
                                      //         "\u00B0C"
                                      //     : "n/a",
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(-10, 5),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      '16:00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Icon(
                                      changeSixteenIcon(),
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      NumberFormat('##').format(_sixteentemp) +
                                          "\u00B0C",
                                      // _sixteentemp != null
                                      //     ? _sixteentemp.toInt().toString() +
                                      //         "\u00B0C"
                                      //     : "n/a",
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(-10, 5),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Text(
                                      '20:00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Icon(
                                      changeTwintyIcon(),
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      NumberFormat('##').format(_twintytemp) +
                                          "\u00B0C",
                                      // _twintytemp != null
                                      //     ? _twintytemp.toInt().toString() +
                                      //         "\u00B0C"
                                      //     : "n/a",
                                      style: TextStyle(
                                          color: Colors.white,
                                          //fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //end hourly section
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
