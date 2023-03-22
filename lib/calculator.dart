import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';

class InterestCalculator extends StatefulWidget {
  @override
  _InterestCalculatorState createState() => _InterestCalculatorState();
}

class _InterestCalculatorState extends State<InterestCalculator> {
  double principal = 1000.0;
  double rate = 5.0;
  int duration = 5;

  List<charts.Series<InterestData, int>> _data = [];

  @override
  void initState() {
    super.initState();
    _calculateInterest();
  }

  void _calculateInterest() {
    List<InterestData> data = [];
    double balance = principal;

    for (int year = 1; year <= duration; year++) {
      double interest = balance * rate / 100;
      balance += interest;

      data.add(InterestData(year, balance));
    }

    setState(() {
      _data = [
        charts.Series(
          id: 'Interest',
          data: data,
          domainFn: (InterestData d, _) => d.year,
          measureFn: (InterestData d, _) => d.amount.toInt(),
        )
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interest Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Principal: \$${principal.toStringAsFixed(2)}'),
            Text('Rate: ${rate.toStringAsFixed(2)}%'),
            Text('Duration: $duration years'),
            SizedBox(height: 16),
            Expanded(
              child: charts.LineChart(
                _data,
                animate: true,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.ChartTitle('Year', behaviorPosition: charts.BehaviorPosition.bottom),
                  charts.ChartTitle('Amount', behaviorPosition: charts.BehaviorPosition.start),
                ],
              ),
            ),
            SizedBox(height: 16),
            DataTable(
              columns: [
                DataColumn(label: Text('Year')),
                DataColumn(label: Text('Amount')),
              ],
              rows: _data[0]
                  .data
                  .map((d) => DataRow(cells: [
                        DataCell(Text(d.year.toString())),
                        DataCell(Text('\$${d.amount.toStringAsFixed(2)}')),
                      ]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestData {
  final int year;
  final double amount;

  InterestData(this.year, this.amount);
}
