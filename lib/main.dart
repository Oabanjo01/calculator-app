import 'package:flutter/material.dart';

import 'screen/home.dart';

void main () {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({ Key? key }) : super(key: key);

  late bool isLight = true;

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp>{ 

  toggleDarkTheme () {
    setState(() {
      widget.isLight = false;
    });
  }

  toggleLightTheme () {
    setState(() {
      widget.isLight = true;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   toggleDarkTheme();
  //   toggleDarkTheme();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(toggleDark: toggleDarkTheme, toggleLight: toggleLightTheme,),
      themeMode: widget.isLight ? ThemeMode.light : ThemeMode.dark,
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