import 'package:corona/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:corona/components/reusable_single_data_card.dart';

class IndividualCountryScreen extends StatelessWidget {
  final Map<String, String> countryData;
  final String countryName;

  IndividualCountryScreen({
    this.countryData,
    this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFB4D9D2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: countryData['flag'] != null
                            ? Image.network(countryData[KFlag])
                            : Image.asset('images/world_flag.png'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        countryName,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Covid-19 Latest Update',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Last Updated: ${countryData[KDate]}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 10),
                child: Row(
                  children: <Widget>[
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.plus,
                      title: 'Affected',
                      number: countryData[KCases],
                      color: Color(0xFFFCCEBF),
                      iconColor: Color(0xFFFFEEE9),
                    ),
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.heart,
                      title: 'Recovered',
                      number: countryData[KRecovered],
                      color: Color(0xFFFBC1D0),
                      iconColor: Color(0xFFc13f62),
                    ),
                    ReusableSingleDataCard(
                        icon: FontAwesomeIcons.times,
                        title: 'Death',
                        number: countryData[KDeaths],
                        color: Color(0xFFFCCEBF),
                        iconColor: Color(0xFFFFEEE9)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 10),
                child: Row(
                  children: <Widget>[
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.plus,
                      title: 'Today Affected',
                      number: countryData[KTodayCases],
                      color: Color(0xFFFCCEBF),
                    ),
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.heart,
                      title: 'Today Recovered',
                      number: countryData[KTodayRecovered],
                      color: Color(0xFFFBC1D0),
                    ),
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.times,
                      title: 'Today Death',
                      number: countryData[KTodayDeaths],
                      color: Color(0xFFFCCEBF),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 10, bottom: 15),
                child: Row(
                  children: <Widget>[
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.medkit,
                      title: 'Critical',
                      number: countryData[KCritical],
                      color: Color(0xFFFBC1D0),
                      iconColor: Color(0xFFdbebe8),
                    ),
                    ReusableSingleDataCard(
                      icon: FontAwesomeIcons.archive,
                      title: 'Overall Active Now',
                      number: countryData[KActive],
                      color: Color(0xFFFBC1D0),
                      iconColor: Color(0xFFdbebe8),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
