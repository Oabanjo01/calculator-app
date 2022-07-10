import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/home.dart';

void main () {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({ Key? key }) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp>{ 

  int themeisLight = 0;

  startingTheme () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getInt('isLight') != null) {
      themeisLight = pref.getInt('isLight')!;
    } else {
      pref.setInt('isLight', themeisLight);
    }
    setState(() {
      
    });
  }

  toggleTheme () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getInt('isLight') == 1) {
      pref.setInt('isLight', 0);
      themeisLight = 0;
    } else {
      pref.setInt('isLight', 1);
      themeisLight = 1;
    }
    setState(() {
      
    });
  }
  @override
  void initState() {
    startingTheme();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   toggleTheme();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(toggle: toggleTheme,),
      themeMode: themeisLight == 1 ? ThemeMode.light : ThemeMode.dark,
      darkTheme: ThemeData(
        splashColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white38),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black54),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), 
                  bottomLeft: Radius.circular(20),
                ),
              )
          )),)
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), 
                  bottomLeft: Radius.circular(20),
                ),
              )
          )),)
      ),
    );
  }
}