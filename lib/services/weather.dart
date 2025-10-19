import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String apiKey = '1c2aa4af07bf069469fef7abc868ac9d';
const String openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();

    print('Lat: ${location.latitude}, Lon: ${location.longitude}');

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) return '🌩';
    if (condition < 400) return '🌧';
    if (condition < 600) return '☔️';
    if (condition < 700) return '☃️';
    if (condition < 800) return '🌫';
    if (condition == 800) return '☀️';
    if (condition <= 804) return '☁️';
    return '🤷‍';
  }

  String getMessage(int temp) {
    if (temp > 25) return 'It\'s 🍦 time';
    if (temp > 20) return 'Time for shorts and 👕';
    if (temp < 10) return 'You\'ll need 🧣 and 🧤';
    return 'Bring a 🧥 just in case';
  }
}
