import 'package:corona/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:corona/components/reusable_card.dart';
import 'package:corona/components/reusable_raw_material_button.dart';
import 'package:corona/components/reusable_scroll_cards.dart';
import 'individual_country_screen.dart';
import 'search_country_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDataScreen extends StatefulWidget {
  final Map<String, Map<String, String>> countryData;
  final Map<String, String> worldData;

  MainDataScreen({this.countryData, this.worldData});

  @override
  _MainDataScreenState createState() => _MainDataScreenState();
}

enum PopulationState { ActiveCases, Dead, Recovered }

class _MainDataScreenState extends State<MainDataScreen> {
  String percentNumber;
  PopulationState selectedState = PopulationState.ActiveCases;
  String overall = KCases;
  String today = KTodayCases;

  double getPercent() {
    int totalAffected = int.parse(widget.worldData[KCases]);
    int recovered = int.parse(widget.worldData[KRecovered]);
    double percent = (recovered / totalAffected) * 100;
    percentNumber = percent.toStringAsFixed(1);
    percent = percent / 100;

    return percent;
  }

  Map<String, String> getSingleData(String countryName) {
    Map<String, String> singleCountryData = {};
    singleCountryData[KDeaths] = widget.countryData[countryName][KDeaths];
    singleCountryData[KCases] = widget.countryData[countryName][KCases];
    singleCountryData[KCritical] = widget.countryData[countryName][KCritical];
    singleCountryData[KRecovered] = widget.countryData[countryName][KRecovered];
    singleCountryData[KTodayRecovered] =
        widget.countryData[countryName][KTodayRecovered];
    singleCountryData[KTodayCases] =
        widget.countryData[countryName][KTodayCases];
    singleCountryData[KFlag] = widget.countryData[countryName][KFlag];
    singleCountryData[KTodayDeaths] =
        widget.countryData[countryName][KTodayDeaths];
    singleCountryData[KActive] = widget.countryData[countryName][KActive];
    singleCountryData[KDate] = widget.countryData[countryName][KDate];
    return singleCountryData;
  }

  Future<void> launchUrl() async {
    const url =
        'https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Color(0xFFB4D9D2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset('images/doc.png'),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '5 Symptoms Of Covid-19',
                            style: KBigTextStyle,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: ReusableRawMaterialButton(
                              horizontalPadding: 30.0,
                              text: Text('Read more'),
                              fillColor: Color(0xFF00332A),
                              textColor: Colors.white,
                              radius: 10.0,
                              onPressed: () {
                                launchUrl();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CircularPercentIndicator(
                      backgroundColor: Color(0xFFEFF7F4),
                      //Color(0xFFEFF7F4)
                      progressColor: Color(0xFF6CB3A5),
                      //Color(0xFF6CB3A5)
                      radius: 160.0,
                      lineWidth: 15.0,
                      animation: true,
                      percent: getPercent(),
                      center: new Text(
                        percentNumber + '%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      child: Column(
                        children: <Widget>[
                          ReusableCard(
                            iconData: Icon(
                              Icons.local_hospital,
                              color: Colors.black,
                            ),
                            number: widget.worldData[KCases],
                            startingColor: Colors.white,
                            endingColor: Color(0xFFFEE3CE),
                            title: 'Affected',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ReusableCard(
                            iconData: Icon(
                              Icons.cake,
                              color: Colors.black,
                            ),
                            number: widget.worldData[KRecovered],
                            startingColor: Colors.white,
                            endingColor: Color(0xFFB4D9D2),
                            title: 'Recovered',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: -1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableRawMaterialButton(
                    text: Text(
                      'Active Cases',
                      style: KMediumTextStyle.apply(
                        color: selectedState == PopulationState.ActiveCases
                            ? KSelectedButtonTextColor
                            : KNotSelectedButtonTextColor,
                      ),
                    ),
                    textColor: Colors.black,
                    radius: 10.0,
                    horizontalPadding: 15.0,
                    fillColor: selectedState == PopulationState.ActiveCases
                        ? KSelectedButtonBackgroundColor
                        : KNotSelectedButtonBackgroundColor,
                    onPressed: () {
                      setState(() {
                        selectedState = PopulationState.ActiveCases;
                        overall = KCases;
                        today = KTodayCases;
                      });
                    },
                  ),
                  ReusableRawMaterialButton(
                    text: Text(
                      'Dead',
                      style: KMediumTextStyle,
                    ),
                    textColor: selectedState == PopulationState.Dead
                        ? KSelectedButtonTextColor
                        : KNotSelectedButtonTextColor,
                    radius: 10.0,
                    horizontalPadding: 35.0,
                    fillColor: selectedState == PopulationState.Dead
                        ? KSelectedButtonBackgroundColor
                        : KNotSelectedButtonBackgroundColor,
                    onPressed: () {
                      setState(() {
                        selectedState = PopulationState.Dead;
                        overall = KDeaths;
                        today = KTodayDeaths;
                      });
                    },
                  ),
                  ReusableRawMaterialButton(
                    text: Text(
                      'Recovered',
                      style: KMediumTextStyle,
                    ),
                    textColor: selectedState == PopulationState.Recovered
                        ? KSelectedButtonTextColor
                        : KNotSelectedButtonTextColor,
                    radius: 10.0,
                    horizontalPadding: 15.0,
                    fillColor: selectedState == PopulationState.Recovered
                        ? KSelectedButtonBackgroundColor
                        : KNotSelectedButtonBackgroundColor,
                    onPressed: () {
                      setState(() {
                        selectedState = PopulationState.Recovered;
                        overall = KRecovered;
                        today = KTodayRecovered;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: -1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Top Country',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  FlatButton(
                    child: Text('See more'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SearchCountryScreen();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: ListView(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ReusableScrollCards(
                    color: Color(0xFFFEE3CE),
                    countryName: KTopCountry[0],
                    flag: widget.countryData[KTopCountry[0]][KFlag],
                    overallCount: widget.countryData[KTopCountry[0]][overall],
                    todayCount: widget.countryData[KTopCountry[0]][today],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryName: KTopCountry[0],
                            countryData: getSingleData(KTopCountry[0]),
                          );
                        }),
                      );
                    },
                  ),
                  ReusableScrollCards(
                    color: Color(0xFFFBD4E6),
                    countryName: KTopCountry[1],
                    flag: widget.countryData[KTopCountry[1]][KFlag],
                    overallCount: widget.countryData[KTopCountry[1]][overall],
                    todayCount: widget.countryData[KTopCountry[1]][today],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryName: KTopCountry[1],
                            countryData: getSingleData(KTopCountry[1]),
                          );
                        }),
                      );
                    },
                  ),
                  ReusableScrollCards(
                    color: Color(0xFFFCD4D4),
                    countryName: KTopCountry[2],
                    flag: widget.countryData[KTopCountry[2]][KFlag],
                    overallCount: widget.countryData[KTopCountry[2]][overall],
                    todayCount: widget.countryData[KTopCountry[2]][today],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryName: KTopCountry[2],
                            countryData: getSingleData(KTopCountry[2]),
                          );
                        }),
                      );
                    },
                  ),
                  ReusableScrollCards(
                    color: Color(0xFFDBEBE8),
                    countryName: KTopCountry[3],
                    flag: widget.countryData[KTopCountry[3]][KFlag],
                    overallCount: widget.countryData[KTopCountry[3]][overall],
                    todayCount: widget.countryData[KTopCountry[3]][today],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryName: KTopCountry[3],
                            countryData: getSingleData(KTopCountry[3]),
                          );
                        }),
                      );
                    },
                  ),
                  ReusableScrollCards(
                    color: Color(0xFF99e5db),
                    countryName: KTopCountry[4],
                    flag: widget.countryData[KTopCountry[4]][KFlag],
                    overallCount: widget.countryData[KTopCountry[4]][overall],
                    todayCount: widget.countryData[KTopCountry[4]][today],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return IndividualCountryScreen(
                            countryName: KTopCountry[4],
                            countryData: getSingleData(KTopCountry[4]),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
