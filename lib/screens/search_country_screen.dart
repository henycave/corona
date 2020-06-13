import 'package:flutter/material.dart';
import 'individual_country_screen.dart';
import 'package:corona/services/networking.dart';

class SearchCountryScreen extends StatefulWidget {
  @override
  _SearchCountryScreenState createState() => _SearchCountryScreenState();
}

class _SearchCountryScreenState extends State<SearchCountryScreen> {
  String countryName;
  Color color = Colors.white;
  Map<String, String> selectedCountryData = {};
  Map<String, String> worldData = {};

  Future<void> getData(String countryName) async {
    Networking networking = Networking();
    selectedCountryData = await networking.getSelectedCountryData(countryName);
  }

  Future<void> getWorldData() async {
    Networking networking = Networking();
    worldData = await networking.getWorldData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                      color: Color(0xFF00332A),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await getWorldData();
                      setState(() {
                        if (worldData.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return IndividualCountryScreen(
                                countryData: worldData,
                                countryName: 'World',
                              );
                            }),
                          );
                        }
                      });
                    },
                    child: Text('World Data'),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    countryName = value;
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFB4D9D2),
                    icon: Icon(
                      Icons.location_city,
                      color: Color(0xFF00332A),
                    ),
                    hintText: 'Enter Country Name',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  await getData(countryName);
                  setState(() {
                    if (selectedCountryData.isEmpty) {
                      color = Colors.red;
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryData: selectedCountryData,
                            countryName: countryName,
                          );
                        }),
                      );
                    }
                  });
                },
                child: Text(
                  'Get Country Data',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF00332A),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Country not found',
                    style: TextStyle(color: color, fontSize: 15),
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
