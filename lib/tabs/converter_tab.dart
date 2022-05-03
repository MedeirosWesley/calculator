import 'dart:ui';

import 'package:calculator/consts.dart';
import 'package:flutter/material.dart';

class Converter extends StatelessWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decimalController = TextEditingController();
    final binaryController = TextEditingController();
    final hexdecimalController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    void _binvalidator(String text) {}

    void _decimalChange(String text) {
      int value;
      if (text.isEmpty) {
        value = 0;
      } else {
        value = int.parse(text);
      }
      binaryController.text = value.toRadixString(2);
      hexdecimalController.text = value.toRadixString(16);
    }

    void _binaryChange(String text) {
      int num = 0;
      if (text.isEmpty) {
        text = "0";
      } else {
        num = int.parse(text, radix: 2);
      }
      decimalController.text = num.toString();
      hexdecimalController.text = num.toRadixString(16);
    }

    void _hexdecimalChange(String text) {
      int num = 0;
      if (text.isEmpty) {
        text = "0";
      } else {
        num = int.parse(text, radix: 16);
      }
      decimalController.text = num.toString();
      binaryController.text = num.toRadixString(2);
    }

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
              height: height / 4,
              width: width,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const Text(
                        "Conversor",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Image.asset('images/binaryIcon.png'),
                    ],
                  ))),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                buildTextFild(
                    "Decimal", "123", decimalController, _decimalChange),
                const SizedBox(
                  height: 20,
                ),
                buildTextFild(
                    "Binário", "1111011", binaryController, _binaryChange),
                const SizedBox(
                  height: 20,
                ),
                buildTextFild("Hexadecimal", "7b", hexdecimalController,
                    _hexdecimalChange),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  buildTextFild(String label, String hintText, TextEditingController controller,
      Function(String) f) {
    Color color = Colors.white;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: color.withOpacity(.5))),
      style: TextStyle(color: color),
      keyboardType: TextInputType.number,
      onChanged: f,
    );
  }
}
