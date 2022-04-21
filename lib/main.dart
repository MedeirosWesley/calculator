import 'package:calculator/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int i = 0;
  String mainDisplay = "0";
  String minDisplay = "";
  bool isdecimal = false;
  String decimalnumber = "0.";
  String currentNumber = "";
  List<double> values = [];

  display(String i) {
    double? num = double.tryParse(i);
    setState(() {
      if (num != null) {
        if (mainDisplay == "0") {
          mainDisplay = i;
        } else {
          mainDisplay += i;
          currentNumber += i;
        }
      }
    });
    //else {
    //   mainDisplay += i;
    //   switch (i) {
    //     case "+":
    //       sum(i);
    //       break;
    //     case "-":
    //       minus(i);
    //       break;
    //     case "/":
    //       divide(i);
    //       break;
    //     case "*":
    //       multply(i);
    //       break;
    //     case "%":
    //       percent(i);
    //       break;
    //     case "( )":
    //       parentheses(i);
    //       break;
    //     case "C":
    //       clean();
    //       break;
    //     case "+/-":
    //       negative();
    //       break;
    //     case ",":
    //       comma();
    //       break;
    //     case "=":
    //       iqual();
    //       break;
    //     default:
    //       break;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: secundaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        minDisplay,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                const Divider(),
                Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: secundaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        mainDisplay,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            flex: 3,
            child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                    color: secundaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    buildColumn(['C', '7', '4', '1', '+/-'], false),
                    buildColumn(['( )', '8', '5', '2', '0'], false),
                    buildColumn(['%', '9', '6', '3', ','], false),
                    buildColumn(['/', '*', '-', '+', '='], true)
                  ],
                )),
          ),
        ],
      ),
    );
  }

  button(String i, bool? b) {
    Color color;
    Color txtColor;
    if (b == null) {
      color = Colors.green;
      txtColor = Colors.white;
    } else {
      color = primaryColor;
      txtColor = b ? Colors.amber : Colors.white;
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          style: ButtonStyle(
              animationDuration: Duration(microseconds: 10),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              backgroundColor: MaterialStateProperty.all<Color>(color)),
          onPressed: () {
            display(i);
          },
          child: Text(
            i,
            style: TextStyle(
                fontSize: 30, color: txtColor, fontWeight: FontWeight.w400),
          )),
    );
  }

  buildColumn(List<String> btns, bool b) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: button(btns[0], true)),
            Expanded(child: button(btns[1], b)),
            Expanded(child: button(btns[2], b)),
            Expanded(child: button(btns[3], b)),
            Expanded(child: button(btns[4], b ? null : b)),
          ],
        ));
  }
}
