import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';


class WeatherFontPage extends StatefulWidget {
  @override
  _WeatherFontPageState createState() => _WeatherFontPageState();
}

class _WeatherFontPageState extends State<WeatherFontPage> {
  //start for weather info
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
  //_dt,
      _location;

  DateTime _date = DateTime.now();
  //DateTime _time = DateTime.now();

  Future getWeatherInfo() async {

    var _lat,_lon;
    final _geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _lat = _geoposition.latitude;
      _lon = _geoposition.longitude;
    });
    // http.Response _response = await http.get(
    //     "https://api.openweathermap.org/data/2.5/onecall?lat=23.74881122030877&lon=90.40286583068159&exclude=alerts&units=metric&appid=32511dee4a22469574a36f13f8be3c55");

    http.Response _response = await http.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=${_lat.toString()}&lon=${_lon.toString()}&exclude=alerts&units=metric&appid=32511dee4a22469574a36f13f8be3c55");

    var _jsondecode = jsonDecode(_response.body);

    setState(() {
      //this._dt = _jsondecode["current"]["dt"];
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
      this._foreight = _jsondecode["hourly"][8]["dt"];
      this._fortwelve = _jsondecode["hourly"][12]["dt"];
      this._forsixteen = _jsondecode["hourly"][16]["dt"];
      this._fortwinty = _jsondecode["hourly"][20]["dt"];
    });
  }

  changeIcon() {
    if (_description == "Rain") {
      return WeatherIcons.wiRainMix;
    } else if (_description == "Clouds") {
      return WeatherIcons.wiCloudy;
    } else if (_description == "Clear") {
      return WeatherIcons.wiSunrise;
    } else if (_description == "Haze") {
      return WeatherIcons.wiDayHaze;
    } else {
      return WeatherIcons.wiDayHaze;
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
    // else if (_description == "Haze") {
    //   return AssetImage('images/haze.jpg');
    // } else {
    //   return AssetImage('images/haze.jpg');
    // }
  }

  //for today section icon change
  var _foreight,
      _fortwelve,
      _forsixteen,
      _fortwinty;

  changeEightIcon() {
    if (_foreighticon == "Rain" && _foreight == _foreight) {
      return WeatherIcons.wiDayRain;
    } else if (_foreighticon == "Clouds" && _foreight == _foreight) {
      return WeatherIcons.wiDayCloudy;
    } else if (_foreighticon == "Clear" && _foreight == _foreight) {
      return WeatherIcons.wiDaySunny;
    } else if (_foreighticon == "Haze" && _foreight == _foreight) {
      return WeatherIcons.wiDayHaze;
    } else {
      return WeatherIcons.wiDayHaze;
    }
  }

  changeTwelveIcon() {
    if (_fortwelveicon == "Rain" && _fortwelve == _fortwelve) {
      return WeatherIcons.wiRainMix;
    } else if (_fortwelveicon == "Clouds" && _fortwelve == _fortwelve) {
      return WeatherIcons.wiCloudy;
    } else if (_fortwelveicon == "Clear" && _fortwelve == _fortwelve) {
      return WeatherIcons.wiDaySunny;
    } else if (_fortwelveicon == "Haze" && _fortwelve == _fortwelve) {
      return WeatherIcons.wiDayHaze;
    } else {
      return WeatherIcons.wiDayHaze;
    }
  }

  changeSixteenIcon() {
    if (_forsixteenicon == "Rain" && _forsixteen == _forsixteen) {
      return WeatherIcons.wiDayRain;
    } else if (_forsixteenicon == "Clouds" && _forsixteen == _forsixteen) {
      return WeatherIcons.wiDayCloudy;
    } else if (_forsixteenicon == "Clear" && _forsixteen == _forsixteen) {
      return WeatherIcons.wiSunset;
    } else if (_forsixteenicon == "Haze" && _forsixteen == _forsixteen) {
      return WeatherIcons.wiNightAltCloudy;
    } else {
      return WeatherIcons.wiNightAltCloudy;
    }
  }

  changeTwintyIcon() {
    if (_fortwintyicon == "Rain" && _fortwinty == _fortwinty) {
      return WeatherIcons.wiNightAltRainMix;
    } else if (_fortwintyicon == "Clouds" && _fortwinty == _fortwinty) {
      return WeatherIcons.wiNightAltCloudy;
    } else if (_fortwintyicon == "Clear" && _fortwinty == _fortwinty) {
      return WeatherIcons.wiNightClear;
    } else if (_fortwintyicon == "Haze" && _fortwinty == _fortwinty) {
      return WeatherIcons.wiNightAltCloudy;
    } else {
      return WeatherIcons.wiNightAltCloudy;
    }
  }
  //end today section icon change
  //Start for geolocation

  // var _lat,_lon;
  // Position _position;
  // Address _address;
  // StreamSubscription<Position> _streamsubscription;
  //
  // // Future convertCoordinateToAddress(Coordinates coordinates) async{
  // //   var _findaddress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // //   return _findaddress.first;
  // // }
  //
  //getLocation() async{
  // final _geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // var _locationoption = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  // _streamsubscription = Geolocator().getPositionStream(_locationoption).listen((Position position) {
  //   setState(() {
  //     _position = position;
  //     final _coordinates = new Coordinates(position.latitude, position.longitude);
  //     convertCoordinateToAddress(_coordinates).then((value) => _address = value);
  //   });
  // });
  // setState(() {
  //   _lat = _geoposition.latitude;
  //   _lon = _geoposition.longitude;
  // });
  //}

  //end geolocation function

  //start for drop section

  var _dropdownvalue = 'English';

  //end for drop section

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeatherInfo();
    //getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          // Icon(
                          //   Icons.access_time_sharp,
                          //   color: Colors.white,
                          //   size: 16,
                          // ),
                          // Text(
                          //   DateFormat(' H:m').format(_time),
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          // Spacer(),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            _location != null ? _location.toString() : "load",
                            //_address?.addressLine ?? " asdqf",
                            // _location.toString(),
                            style: TextStyle(
                              fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.black,
                              elevation: 0,
                              hint: Text(
                                _dropdownvalue,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              icon: Icon(
                                Icons.language_outlined,
                                color: Colors.teal,
                                size: 35,
                              ),

                              items: [

                                DropdownMenuItem(
                                  onTap: (){
                                    setState(() {
                                      EasyLocalization.of(context).locale = Locale("bn", "BN");
                                    });
                                  },
                                  child: Text("বাংলা",style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),),
                                  value: "বাংলা",
                                ),
                                DropdownMenuItem(
                                  onTap: (){
                                    setState(() {
                                      EasyLocalization.of(context).locale = Locale("en", "EN");
                                    });
                                  },
                                  child: Text("English",style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),),
                                  value: "English",
                                ),

                              ],
                              onChanged: (_selectvalue) {
                                setState(() {
                                  _dropdownvalue = _selectvalue;
                                });
                              },
                            ),
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
                                    _temp != null ? NumberFormat('##').format(_temp) +
                                        "\u00B0C" : "Loading",
                                    // NumberFormat('##').format(_temp) +
                                    //     "\u00B0C",
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
                                      fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(_date),
                                    style: TextStyle(
                                      fontSize: 20,
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
                                    _minitemp != null ? NumberFormat('##').format(_minitemp) +
                                        "\u00B0C - " +
                                        NumberFormat('##').format(_maxtemp) +
                                        "\u00B0C" : "load",
                                    // NumberFormat('##').format(_minitemp) +
                                    //     "\u00B0C - " +
                                    //     NumberFormat('##').format(_maxtemp) +
                                    //     "\u00B0C",

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
                                    _clouds != null ? 'Clouds'.tr().toString() + _clouds.toString() + "%" : "load",
                                    // 'Clouds'.tr().toString() + _clouds.toString() + "%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),

                                  Text(
                                    _wind != null ? 'Wind'.tr().toString() +
                                        NumberFormat('##').format(_wind) +
                                        // _wind.toInt().toString() +
                                        "km/h" : "load",
                                    // 'Wind'.tr().toString() +
                                    //     NumberFormat('##').format(_wind) +
                                    //     // _wind.toInt().toString() +
                                    //     "km/h",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _humidity != null ? 'Humidity'.tr().toString() + _humidity.toString() + '%' : "load",
                                    // 'Humidity'.tr().toString() + _humidity.toString() + '%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _feellike != null ? 'Feels like'.tr().toString() +
                                        NumberFormat('##').format(_feellike) +
                                        "\u00B0C" : "load",
                                    // 'Feels like'.tr().toString() +
                                    //     NumberFormat('##').format(_feellike) +
                                    //     "\u00B0C",
                                    // _feellike.toInt().toString() +
                                    // '\u00B0C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _visibility != null ? 'Visibility'.tr().toString() +
                                        NumberFormat('##').format(_visibility) +
                                        // _visibility.toString() +
                                        'm': "load",
                                    // 'Visibility'.tr().toString() +
                                    //     NumberFormat('##').format(_visibility) +
                                    //     // _visibility.toString() +
                                    //     'm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _pressure != null ? 'Pressure'.tr().toString() + _pressure.toString() + 'mb' : "load",
                                    // 'Pressure'.tr().toString() + _pressure.toString() + 'mb',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _dewpoint != null ? 'Dew Point'.tr().toString() +
                                        NumberFormat('##').format(_dewpoint) +
                                        //_dewpoint.toInt().toString() +
                                        '%' : "load",
                                    // 'Dew Point'.tr().toString() +
                                    //     NumberFormat('##').format(_dewpoint) +
                                    //     //_dewpoint.toInt().toString() +
                                    //     '%',
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
                                    _moonphase != null ? 'Moon Phase'.tr().toString()+_moonphase.toString()+'\u00B0' : "load",
                                    // 'Moon Phase'.tr().toString()+_moonphase.toString()+'\u00B0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    _precipitation != null ? 'Precipitation'.tr().toString() +
                                        NumberFormat('###.0#')
                                            .format(_precipitation) +
                                        //_precipitation.toString() +
                                        '%' : "load",
                                    // 'Precipitation'.tr().toString() +
                                    //     NumberFormat('###.0#')
                                    //         .format(_precipitation) +
                                    //     //_precipitation.toString() +
                                    //     '%',
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
                            'Today'.tr().toString(),
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
                                      '08:00'.tr().toString(),
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
                                      _eighttemp != null ? NumberFormat('##').format(_eighttemp) +
                                          "\u00B0C" : "load",
                                      // NumberFormat('##').format(_eighttemp) +
                                      //     "\u00B0C",
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
                                      '12:00'.tr().toString(),
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
                                      _twelvetemp != null ? NumberFormat('##').format(_twelvetemp) +
                                          "\u00B0C" : "load",
                                      // NumberFormat('##').format(_twelvetemp) +
                                      //     "\u00B0C",
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
                                      '16:00'.tr().toString(),
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
                                      _sixteentemp != null ? NumberFormat('##').format(_sixteentemp) +
                                          "\u00B0C" : "load",
                                      // NumberFormat('##').format(_sixteentemp) +
                                      //     "\u00B0C",
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
                                      '20:00'.tr().toString(),
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
                                      _twintytemp != null ? NumberFormat('##').format(_twintytemp) +
                                          "\u00B0C" : "load",
                                      // NumberFormat('##').format(_twintytemp) +
                                      //     "\u00B0C",
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
