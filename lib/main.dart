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
  String mainDisplay = "0";
  String minDisplay = "";
  String operation = "";
  String result = "";
  double? n1, n2, n3;
  bool reset = false;

  // Transforma doble para int para ser exibido no display
  String isInt() {
    int i = n1!.toInt();
    return i.toString();
  }

  // Controle e logica dos displays
  display(String i) => setState(() {
        switch (i) {
          case 'C':
            clean();
            break;
          case '%':
            if (n1 != null) {
              n2 = double.parse(mainDisplay);
              minDisplay = minDisplay + mainDisplay + '%';
              n3 = n1;
              calc('%');
              n2 = n3;
              calc(operation);
              result = (n1! % 1 == 0) ? isInt() : n1.toString();
              mainDisplay = "0";
              reset = true;
            }
            break;
          case '=':
            if (operation != '') {
              if (!reset) {
                n2 = double.parse(mainDisplay);
                calc(operation);
                minDisplay =
                    (operation != '√') ? minDisplay + mainDisplay : minDisplay;
              }
              mainDisplay = (n1 == null)
                  ? '0'
                  : (n1! % 1 == 0)
                      ? isInt()
                      : n1.toString();
              n2 = 0;
              result = "";
              reset = true;
            }
            break;
          case '.':
            mainDisplay = mainDisplay + ".";
            break;
          default:
            double? num = double.tryParse(i);
            if (num != null) {
              if (mainDisplay == "0") {
                mainDisplay = i;
              } else {
                mainDisplay += i;
              }
            } else if (mainDisplay != '0') {
              if (n1 == null) {
                n1 = double.parse(mainDisplay);
                operation = i;
                if (operation == "√") {
                  reset = true;
                  calc(operation);
                  result = (n1! % 1 == 0) ? isInt() : n1.toString();
                  n2 = 0;
                }
                minDisplay = mainDisplay + operation;
                mainDisplay = "0";
              } else {
                if (reset) {
                  operation = i;
                  minDisplay = (n1! % 1 == 0)
                      ? isInt() + operation
                      : n1.toString() + operation;
                  mainDisplay = "0";
                  reset = false;
                } else {
                  if (operation != "√" && mainDisplay != '0') {
                    n2 = double.parse(mainDisplay);
                    calc(operation);
                    result = (n1! % 1 == 0) ? isInt() : n1.toString();
                    operation = i;
                    minDisplay = minDisplay + mainDisplay + operation;
                  } else {
                    reset = true;
                    operation = i;
                    minDisplay = minDisplay + operation;
                    calc(operation);
                    result = (n1! % 1 == 0) ? isInt() : n1.toString();
                    n2 = 0;
                  }
                  mainDisplay = "0";
                }
              }
            }
        }
      });

  // Controle da operações
  calc(String operation) {
    switch (operation) {
      case "+":
        n1 = calculator.sum(n1!, n2!);
        break;
      case "-":
        n1 = calculator.sub(n1!, n2!);
        break;
      case "/":
        n1 = calculator.divide(n1!, n2!);
        break;
      case "*":
        n1 = calculator.multply(n1!, n2!);
        break;
      case "%":
        n1 = calculator.percent(n1!, n2!);
        break;
      case "√":
        n1 = calculator.sqr(n1!);
        break;
      case "Mod":
        n1 = calculator.mod(n1!, n2!);
        break;
      default:
        break;
    }
  }

  // Reseta a calculadora
  clean() {
    setState(() {
      minDisplay = "";
      mainDisplay = "0";
      result = "";
      operation = "";
      n1 = null;
      n2 = null;
      reset = false;
    });
  }

////////////////////////////////////////////////////////////////////////////////
// Layout
////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            color: secundaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                minDisplay,
                                maxLines: 3,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              result,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white.withOpacity(.5),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )),
                  const Divider(),
                  Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            color: secundaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            mainDisplay,
                            maxLines: 3,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      color: secundaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      buildColumn(['C', '7', '4', '1', 'Mod'], false),
                      buildColumn(['√', '8', '5', '2', '0'], false),
                      buildColumn(['%', '9', '6', '3', '.'], false),
                      buildColumn(['/', '*', '-', '+', '='], true)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //Contrutor de botões
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
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              backgroundColor: MaterialStateProperty.all<Color>(color)),
          onPressed: () {
            display(i);
          },
          child: Text(
            i,
            maxLines: 1,
            style: TextStyle(
                fontSize: (i == 'Mod') ? 20 : 30,
                color: txtColor,
                fontWeight: FontWeight.w400),
          )),
    );
  }

  // Constroi o layout dos botões
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
