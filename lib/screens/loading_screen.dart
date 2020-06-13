import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:corona/services/networking.dart';
import 'main_data_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Map<String, Map<String, String>> countryData;
    Map<String, String> worldData;
    worldData = await Networking().getWorldData();
    countryData = await Networking().getTopCountryData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDataScreen(
          countryData: countryData,
          worldData: worldData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/loadingImg4.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SpinKitWave(
            color: Colors.red[400],
            //Color(0xFFF7C1B5)
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
