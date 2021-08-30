import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  num temperature;
  String cityName;
  String country;
  IconData weatherIcon;
  String weatherMessage;
  var formattedDate;
  String wallurl;
  String main;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weatherModel.getMessage(temperature);

      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);

      main = weatherData['weather'][0]['description'];
      var timezone = weatherData['timezone'];
      var currDate = DateTime.now().toUtc().add(Duration(seconds: timezone));
      formattedDate = formatDate(
        currDate,
        [DD, ' | ', M, ' ', dd, ' | ', HH, ':', nn],
      );
      wallurl = (6 <= currDate.hour && currDate.hour <= 18)
          ? 'weather2-01.jpg'
          : 'weather1-01.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$wallurl'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      FlutterIcons.location_evi,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      FlutterIcons.search1_ant,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Icon(
                          weatherIcon,
                          size: 70,
                        ),
                      ],
                    ),
                    Text(
                      "$main",
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$cityName , $country",
                        style: kMessageTextStyle,
                      ),
                      Text(
                        formattedDate,
                        style: kdateStyle,
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        '$weatherMessage',
                        style: kdescStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
