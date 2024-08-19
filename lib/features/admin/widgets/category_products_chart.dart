// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/admin/models/sales.dart';
import 'package:logger/logger.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> seriesList;
  const CategoryProductsChart({
    super.key,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            titlesData: titlesData,
            barTouchData: barTouchData,
            gridData: const FlGridData(
              show: false,
            ),
          ),
        ),
      ),
    );
  }

  FlTitlesData get titlesData {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          axisNameWidget: const Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          drawBelowEverything: true,
          sideTitles: SideTitles(
              showTitles: true, reservedSize: 30, getTitlesWidget: getTitles)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 13.5,
    );
    String test = "text";
    switch (value) {
      case 1.0:
        test = "Mobiles";
        break;
      case 2.0:
        test = "Essentials";
        break;
      case 3.0:
        test = "Appliances";
        break;
      case 4.0:
        test = "Books";
        break;
      case 5.0:
        test = "Fashion";
        break;
      default:
        test = "text";
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: FittedBox(
          child: Text(
            test,
            style: style,
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> get barGroups {
    var logger = Logger();
    logger.w(seriesList[0].earnings);
    int x = 0;
    return seriesList.map(
      (e) {
        x++;
        return BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              toY: double.parse(
                e.earnings.toString(),
              ),
              borderSide: const BorderSide(style: BorderStyle.solid),
              width: 20,
              color: Colors.purple,
            ),
          ],
          showingTooltipIndicators: [0],
        );
      },
    ).toList();
  }
}
