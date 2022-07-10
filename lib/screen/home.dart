import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.toggle}) : super(key: key);
  var toggle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input = '0';

  var solution = '';

  var output = '0';

  operations (String buttonText){
    
    setState(() {
      if (buttonText == 'AC') {
          input = '0';
          output = '0';
      } else if (buttonText == '⌫') {
        input = input.substring(0, input.length - 1);
        if (input == '') {
          input = '0';
        }
      } else if (buttonText == '=') {
        solution = input;
        solution = solution.replaceAll('×', '*');

        try{
          Parser p = Parser();
          Expression exp = p.parse(solution);

          ContextModel cm = ContextModel();
          output = "${exp.evaluate(EvaluationType.REAL, cm)}";
        }catch(e){
          output = "error";
        }


      } else if (input == '0') {
          input = buttonText;
      } else if (buttonText == '%') {
        solution = input;
        output = (int.parse(solution)/100).toString();
      }
      else {
        input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                    height: size.height * 0.36,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      output,
                      style: TextStyle(
                        fontSize: 50
                      ),
                    )),
                ),
                Positioned(
                  top: 3,
                  left: size.width * 0.25,
                  child: Container(
                    height: size.height * 0.1,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          night_button(),
                          day_button(),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ),
            SizedBox(height: size.height * 0.025,),
            Container(
                width: size.width * 1,
                height: size.height * 0.07,
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  input,
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.end,
                )),
            SizedBox(height: size.height * 0.025,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.grey.withOpacity(0.1),
                ),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Table(
                  children: [
                    TableRow(children: <Widget>[
                      calculatorButton1(size, 'AC', Colors.amber.shade600,
                          Colors.amber.shade300),
                      calculatorButton1(size, '⌫', Colors.amber.shade600,
                          Colors.amber.shade300),
                      calculatorButton1(size, '%', Colors.amber.shade600,
                          Colors.amber.shade300),
                      calculatorButton1(size, '/', Colors.red, Colors.redAccent)
                    ]),
                    TableRow(children: <Widget>[
                      calculatorButton1(
                          size, '7', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '8', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '9', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(size, '×', Colors.red, Colors.redAccent)
                    ]),
                    TableRow(children: <Widget>[
                      calculatorButton1(
                          size, '4', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '5', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '6', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(size, '-', Colors.red, Colors.redAccent)
                    ]),
                    TableRow(children: <Widget>[
                      calculatorButton1(
                          size, '1', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '2', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '3', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(size, '+', Colors.red, Colors.redAccent)
                    ]),
                    TableRow(children: <Widget>[
                      calculatorButton1(
                          size, '', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '0', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(
                          size, '.', Colors.blue.shade400, Colors.black26),
                      calculatorButton1(size, '=', Colors.red, Colors.redAccent)
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonPress() {}

  Widget day_button() {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.wb_sunny_rounded,
        color: Colors.amber,
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ))),
      onPressed: widget.toggle,
      label: const Text(
        'Day',
      ),
    );
  }

  Widget night_button() {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.nightlight,
        color: Colors.black38,
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ))),
      onPressed: widget.toggle,
      label: const Text(
        'Night',
      ),
    );
  }

  InkWell calculatorButton1(
      Size size, String digit, Color buttonColor, Color splashColor) {
    return InkWell(
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(100),
      onTap: () => operations(digit),
      child: Container(
        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
        margin: const EdgeInsets.all(4),
        alignment: Alignment.center,
        width: size.width * 0.25,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (ThemeMode.light == true) ? Colors.white : Colors.white38,
          border: Border.all(style: BorderStyle.none),
        ),
        child: Text(
          digit,
          style: TextStyle(
              color: buttonColor, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

// class NumberButton extends StatelessWidget {
//   const NumberButton({Key? key, required this.size, required this.number, required this.color})
//       : super(key: key);

//   final Size size;
//   final int number;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: size.width * 0.2,
//       // height: size.height * 0.1,
//       decoration: BoxDecoration(
//         color: color,
//       ),
//       child: Center(
//         child: Text(
//           '$number',
//           style: const TextStyle(
//             fontSize: 24
//           ),
//         ),
//       ),
//     );
//   }
// }
