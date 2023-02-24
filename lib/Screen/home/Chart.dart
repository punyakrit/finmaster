import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: Color.fromARGB(255, 172, 141, 178),
            width: 3,
            dataSource: <SalesData>[
              SalesData(100, 'Mon'),
              SalesData(20, 'Tue'),
              SalesData(15, 'Wed'),
              SalesData(40, 'Thu'),
              SalesData(80, 'Sat'),
            ],
            xValueMapper: (SalesData sales, _) => sales.Year,
            yValueMapper: (SalesData sales, _) => sales.Sales,
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.Sales, this.Year);
  final String Year;
  final int Sales;
}
