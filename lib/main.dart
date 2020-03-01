import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './WebViewPage.dart';
import './constants/color_maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF4B4B4B, primarycolor),
        accentColor: MaterialColor(0xFFF4CF4A, secondarycolor),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0),
            child: Image.asset(
              "assets/Logo.png",
              fit: BoxFit.contain,
            ),
          ),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              "Punch Bot",
              style: TextStyle(fontSize: 24.0),
            ),
          )),
        ),
        body: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String statusWord = "";

  Future<SharedPreferences> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      statusWord =
          prefs.getString("status") == null ? "" : prefs.getString("status");
    });

    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    Future<SharedPreferences> preferences = getPrefs();

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: NeuCard(
                curveType: CurveType.convex,
                constraints: BoxConstraints(
                    minHeight: screen.height * 0.1, maxWidth: screen.width * 0.5),
                bevel: 3.0,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 22.0),
                    child: Text(
                      statusWord,
                      style: TextStyle(
                          fontSize: 23.0, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => WebViewPage(
                                  actionType: "clock",
                                )));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: NeuCard(
                curveType: CurveType.convex,
                constraints: BoxConstraints(
                    minHeight: screen.height * 0.1, maxWidth: screen.width * 0.5),
                bevel: 3.0,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 22.0),
                    child: Text(
                      "Just Login",
                      style: TextStyle(
                          fontSize: 23.0, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => WebViewPage(
                                  actionType: "login",
                                )));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/GreyGradient.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
