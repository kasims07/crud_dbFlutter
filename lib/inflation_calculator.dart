import 'dart:math';

import 'package:flutter/material.dart';

class InflationCalculator extends StatefulWidget {
  @override
  _InflationCalculatorState createState() => _InflationCalculatorState();
}

class _InflationCalculatorState extends State<InflationCalculator> {
  final _formKey = GlobalKey<FormState>();

  double _initialAmount = 0.0;
  double _inflationRate = 0.0;
  int _numberOfYears = 0;
  double _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inflation Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Initial Amount',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the initial amount.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _initialAmount = double.parse(value);
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Inflation Rate',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the inflation rate.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _inflationRate = double.parse(value);
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Number of Years',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of years.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _numberOfYears = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculateResult();
                    }
                  },
                  child: Text('Calculate'),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Result: \$${_result.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateResult() {
    double inflationFactor = 1.0 + (_inflationRate / 100.0);
    double result = _initialAmount * pow(inflationFactor, _numberOfYears);
    setState(() {
      _result = result;
    });
  }
}
