import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';
import 'package:kaamai/widgets/background_gradient.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsPage extends StatelessWidget {
  AnalyticsPage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();
  final session = Get.find<Session>();
  final String title = "Analytics";

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient2(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(letterSpacing: 3)),
          // backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        // backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              // ProfileCard(),
              // const Text("Points"),
              // const Text("1,200"),
              _buildDefaultLineChart(),
              const Spacer(),
              const SizedBox(height: 36),
              // const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Order Success Rate '),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(2015, 21, 28),
      _ChartData(2016, 24, 44),
      _ChartData(2017, 36, 48),
      _ChartData(2018, 38, 50),
      _ChartData(2019, 54, 66),
      _ChartData(2020, 57, 78),
      _ChartData(2021, 70, 84)
    ];
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Sales',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'Requests',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
