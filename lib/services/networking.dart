import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona/constants.dart';
import 'package:intl/intl.dart';

//https://disease.sh/v2/countries/Ethiopia

class Networking {
  Map<String, Map<String, String>> _countryData = {};
  Map<String, String> _worldData = {};
  Map<String, String> _selectedCountryData = {};

  Future<dynamic> getWorldData() async {
    http.Response response = await http.get(KBaseUrl + KWorldUrl);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      _worldData[KCases] = body[KCases].toString();
      _worldData[KRecovered] = body[KRecovered].toString();
      _worldData[KTodayRecovered] = body[KTodayRecovered].toString();
      _worldData[KTodayCases] = body[KTodayCases].toString();
      _worldData[KCritical] = body[KCritical].toString();
      _worldData[KDeaths] = body[KDeaths].toString();
      _worldData[KTodayDeaths] = body[KTodayDeaths].toString();
      _worldData[KActive] = body[KActive].toString();
      _worldData[KDate] = setTime();
      return _worldData;
    } else {
      print('$response.statusCode : found error while connecting to server');
      return;
    }
  }

  Future<dynamic> getTopCountryData() async {
    for (String top in KTopCountry) {
      http.Response response = await http.get(KBaseUrl + KCountryUrl + top);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        _countryData[top] = {
          KCases: body[KCases].toString(),
          KTodayCases: body[KTodayCases].toString(),
          KCritical: body[KCritical].toString(),
          KRecovered: body[KRecovered].toString(),
          KTodayRecovered: body[KTodayRecovered].toString(),
          KDeaths: body[KDeaths].toString(),
          KTodayDeaths: body[KTodayDeaths].toString(),
          KActive: body[KActive].toString(),
          KFlag: body[KCountryInfo][KFlag],
          KCountry: body[KCountry],
          KDate: setTime(),
        };
      } else {
        return;
      }
    }
    return _countryData;
  }

//    print('$response.statusCode : found error while connecting to server');

  Future<dynamic> getSelectedCountryData(String countryName) async {
    http.Response response =
        await http.get(KBaseUrl + KCountryUrl + countryName);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      _selectedCountryData[KCases] = body[KCases].toString();
      _selectedCountryData[KTodayCases] = body[KTodayCases].toString();
      _selectedCountryData[KCritical] = body[KCritical].toString();
      _selectedCountryData[KRecovered] = body[KRecovered].toString();
      _selectedCountryData[KTodayRecovered] = body[KTodayRecovered].toString();
      _selectedCountryData[KDeaths] = body[KDeaths].toString();
      _selectedCountryData[KFlag] = body[KCountryInfo][KFlag];
      _selectedCountryData[KTodayDeaths] = body[KTodayDeaths].toString();
      _selectedCountryData[KActive] = body[KActive].toString();
      _selectedCountryData[KCountry] = body[KCountry];
      _selectedCountryData[KDate] = setTime();
      return _selectedCountryData;
    } else if (response.statusCode == 404) {
      return _selectedCountryData;
    } else {
      print('$response.statusCode : found error while connecting to server');
      return;
    }
  }

  String setTime() {
    var dt = DateTime.now();
    var newDt = DateFormat.yMMMEd().format(dt);
    return newDt.toString();
  }
}
