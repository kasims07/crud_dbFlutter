import 'dart:math';

import 'package:flutter/material.dart';

class SevingCalculator extends StatefulWidget {
  const SevingCalculator({super.key});

  @override
  _SevingCalculatorState createState() => _SevingCalculatorState();
}

class _SevingCalculatorState extends State<SevingCalculator> {
  // controller
  TextEditingController principalTextEditingController = TextEditingController();
  TextEditingController rateofInterestTextEditingController = TextEditingController();
  TextEditingController termTextEditingController = TextEditingController();

  // currencies
  final _currencies = ['Rupees', 'Dollars', 'Pounds'];

  String result = "";
  String _character = "";
  String currentValue = "";
  String nv = "";

  @override
  void initState() {
    currentValue = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Interest Calculator",
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //image
            getImage(),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    title: const Text(
                      "Simple Interest",
                      style: TextStyle(fontSize: 13),
                    ),
                    leading: Radio(
                      value: "simple",
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          // here it is simple
                          _character = value!;
                        });
                      },
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    title: const Text(
                      "Coumpound Interest",
                      style: TextStyle(fontSize: 13),
                    ),
                    leading: Radio(
                      value: "coumpound",
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          // here it is simple
                          _character = value!;
                        });
                      },
                    ),
                  ),
                )),
                Container(
                  width: 5.0,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: principalTextEditingController,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: "Principal",
                    hintText: "Enter a principal amount e.g, 1099",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: rateofInterestTextEditingController,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: "Rate of Interest",
                    hintText: "Enter a rate per year",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      controller: termTextEditingController,
                      decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.black),
                          labelText: "Term",
                          hintText: "Enter number of year",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ),
                Container(
                  width: 10,
                ),

                // dropdown menu
                Expanded(
                  child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: currentValue,
                    onChanged: (newValue) {
                      _setSelectedValue(newValue!);
                      nv = newValue;
                      setState(() {
                        currentValue = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Expanded(
                    child: TextButton(
                  child: const Text(
                    "CALCULATE",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    result = _getEffectiveAmount(nv);
                    onDialogOpen(context, result);
                  },
                )),
                Container(
                  width: 10,
                ),
                Expanded(
                    child: TextButton(
                  child: const Text(
                    "RESET",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    _reset();
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _setSelectedValue(String newValue) {
    setState(() {
      currentValue = newValue;
    });
  }

  String _getEffectiveAmount(String newValue) {
    String newResult;
    double principal = double.parse(principalTextEditingController.text);
    double rate = double.parse(rateofInterestTextEditingController.text);
    double term = double.parse(termTextEditingController.text);

    double netpayableAmount = 0;
    if (_character == "simple") {
      netpayableAmount = principal + (principal * rate * term) / 100;
    } else if (_character == "compound") {
      netpayableAmount = principal * pow((1 + (rate / 100)), term);
    }

    if (term == 1) {
      newResult = "After $term year, you will have to pay total amount = $netpayableAmount $currentValue";
    } else {
      newResult = "After $term year, you will have to pay total amount = $netpayableAmount $currentValue";
    }
    return newResult;
  }

  void _reset() {
    principalTextEditingController.text = "";
    rateofInterestTextEditingController.text = "";
    termTextEditingController.text = "";
    result = "";
    currentValue = _currencies[0];
  }

  // dialog box

  void onDialogOpen(BuildContext context, String s) {
    var alertDialog = AlertDialog(
      title: const Text("NP is selected...."),
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 8.0,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(s),
          );
        });
  }
}

Widget getImage() {
  AssetImage assetImage = const AssetImage("assets/back.png");
  Image image = Image(
    image: assetImage,
    width: 150,
    height: 150,
  );

  return Container(
    margin: const EdgeInsets.all(30),
    child: image,
  );
}
