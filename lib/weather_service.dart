
import 'package:weather/weather.dart';

class WeatherService {
  final String apiKey = '6660a305d57a0c24d0e7681997f4c954'; 
  late WeatherFactory _weatherFactory;

  WeatherService() {
    _weatherFactory = WeatherFactory(apiKey);
  }

  Future<Weather> getCurrentWeather(String cityName) async {
    Weather weather = await _weatherFactory.currentWeatherByCityName(cityName);
    return weather;
  }
}
