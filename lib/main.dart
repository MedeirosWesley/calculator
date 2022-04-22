import 'package:calculator/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';

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
  Calculator calculator = Calculator();
  int i = 0;
  String mainDisplay = "0";
  String minDisplay = "";
  bool isdecimal = false;
  String operation = "";
  String currentNumber = "";
  double? n1, n2;

  display(String i) {
    setState(() {
      if (i == "=") {
        if (n1 != null && n2 != null) {}
      } else {
        double? num = double.tryParse(i);
        if (num != null) {
          if (mainDisplay == "0") {
            mainDisplay = i;
            currentNumber += i;
          } else {
            mainDisplay += i;
            currentNumber += i;
          }
        } else {
          if (n1 == null) {
            n1 = double.parse(currentNumber);
            currentNumber = "";
            mainDisplay = "0";
          } else {
            n2 = double.parse(currentNumber);
            currentNumber = "";
          }
          minDisplay = mainDisplay + i;
          mainDisplay == "0";
          operation = i;
        }
      }
    });
  }

  calc() {
    switch (operation) {
      case "+":
        minDisplay = calculator.sum(n1!, n2!).toString();
        break;
      case "-":
        minDisplay = calculator.sub(n1!, n2!).toString();
        break;
      case "/":
        minDisplay = calculator.divide(n1!, n2!).toString();
        break;
      case "*":
        minDisplay = calculator.multply(n1!, n2!).toString();
        break;
      case "%":
        minDisplay = calculator.percent(n1!, n2!).toString();
        break;
      default:
        break;
    }
  }

  clean() {
    setState(() {
      if (mainDisplay == "0") {
        minDisplay = "";
      } else {
        mainDisplay == "0";
      }
    });
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
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: secundaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        minDisplay,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(.5),
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                const Divider(),
                Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          color: secundaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        mainDisplay,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            decoration: TextDecoration.none,
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
                    buildColumn(['√', '8', '5', '2', '0'], false),
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
