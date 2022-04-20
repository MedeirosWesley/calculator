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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
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
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900.withOpacity(.5),
                          borderRadius: BorderRadius.circular(20)),
                    )),
                const Divider(),
                Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900.withOpacity(.5),
                          borderRadius: BorderRadius.circular(20)),
                    )),
              ],
            ),
          ),
          const Divider(),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade900.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)),
              )),
        ],
      ),
    );
  }
}
