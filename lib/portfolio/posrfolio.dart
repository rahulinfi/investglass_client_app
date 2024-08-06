import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kleber_bank/main.dart';
import 'package:kleber_bank/portfolio/portfolio_controller.dart';
import 'package:kleber_bank/portfolio/positions.dart';
import 'package:kleber_bank/portfolio/transactions.dart';
import 'package:kleber_bank/utils/app_styles.dart';
import 'package:kleber_bank/utils/app_widgets.dart';
import 'package:kleber_bank/utils/common_functions.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/app_colors.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  late PortfolioController _notifier;

  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<PortfolioController>(context);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: rSize * 0.015, vertical: rSize * 0.005),
            child: Padding(
              padding: EdgeInsets.all(rSize * 0.01),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _notifier.selectIndex(index),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'ALPHA',
                          style: AppStyles.c656262W500S16,
                        )),
                        if (_notifier.selectedIndex != index) ...{
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Net Value',
                                style: AppStyles.c656262W500S14,
                              ),
                              Text(
                                'CHF 100,000,000.00',
                                style: AppStyles.c656262W400S16,
                              ),
                            ],
                          ),
                        },
                        SizedBox(
                          width: rSize * 0.015,
                        ),
                        RotatedBox(
                            quarterTurns: _notifier.selectedIndex == index ? 1 : 3,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.kTextFieldInput,
                              size: 15,
                            ))
                      ],
                    ),
                  ),
                  if (_notifier.selectedIndex == index) ...{
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: rSize * 0.5,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: rSize * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.kViolate.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(rSize * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppWidgets.portfolioListElement('Date', '2024-08-02'),
                                SizedBox(
                                  height: rSize * 0.005,
                                ),
                                AppWidgets.portfolioListElement('Net Value', 'CHF 100,000,000.00'),
                                SizedBox(
                                  height: rSize * 0.005,
                                ),
                                AppWidgets.portfolioListElement('PortFolio Value', 'CHF 100,000,000.00'),
                                SizedBox(
                                  height: rSize * 0.005,
                                ),
                                AppWidgets.portfolioListElement('Amount Invested', 'CHF 0.00'),
                                SizedBox(
                                  height: rSize * 0.005,
                                ),
                                AppWidgets.portfolioListElement('Date', 'CHF 100,000,000.00 (100%)'),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                AppWidgets.divider(),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                Text(
                                  'Performance :-',
                                  style: AppStyles.c656262W400S16,
                                ),
                                SizedBox(
                                  height: rSize * 0.035,
                                ),
                                lineChart(),
                                AppWidgets.divider(),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                Text(
                                  'Assets Class :-',
                                  style: AppStyles.c656262W400S16,
                                ),
                                SizedBox(
                                  height: rSize * 0.02,
                                ),
                                columnChart(),
                                AppWidgets.divider(),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                Text(
                                  'Currency :-',
                                  style: AppStyles.c656262W400S16,
                                ),
                                SizedBox(
                                  height: rSize * 0.02,
                                ),
                                columnChart(),
                                AppWidgets.divider(),
                                SizedBox(
                                  height: rSize * 0.02,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Health Alerts',
                                      style: AppStyles.c656262W400S16,
                                    )),
                                    /*Text(
                                      'Details',
                                      style: AppStyles.c3C496CW500S16,
                                    ),
                                    const RotatedBox(
                                        quarterTurns: 2,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColors.kViolate,
                                          size: 12,
                                        ))*/
                                  ],
                                ),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                healthAlertElement('   Minor Issues', '24', Colors.blue, Icons.info_outline,'Suitability','Not checked'),
                                SizedBox(
                                  height: rSize * 0.015,
                                ),
                                healthAlertElement('   Major Issues', '3', Colors.red, Icons.report_problem_outlined,'Appropriateness','Not checked'),
                                SizedBox(
                                  height: rSize * 0.02,
                                ),
                                Row(
                                  children: [
                                    Expanded(child: GestureDetector(
                                        onTap: () {
                                          CommonFunctions.navigate(context, Positions());
                                        },
                                        child: AppWidgets.btn('Positions'))),
                                    SizedBox(
                                      width: rSize * 0.01,
                                    ),
                                    Expanded(child: GestureDetector(
                                        onTap: () => CommonFunctions.navigate(context, Transactions()),
                                        child: AppWidgets.btn('Transactions'))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  }
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container healthAlertElement(String title, String number, Color bgColor, IconData iconData,String label,String valueOfLabel) {
    return Container(
      decoration: BoxDecoration(color: bgColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: rSize * 0.02, vertical: rSize * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: bgColor,
                size: 20,
              ),
              Expanded(
                  child: Text(
                title,
                style: AppStyles.c656262W400S16.copyWith(color: bgColor),
              )),
              Text(
                number,
                style: AppStyles.c656262W400S16.copyWith(color: bgColor),
              )
            ],
          ),
          SizedBox(height: rSize*0.01,),
          Text(
            label,
            style: AppStyles.c656262W500S14,
          ),
          Text(
            valueOfLabel,
            style: AppStyles.c656262W200S14,
          )
        ],
      ),
    );
  }

  Widget lineChart() {
    return SizedBox(
      height: rSize * 0.2,
      width: rSize * 0.3,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              isStepLineChart: false,
              spots: [20.50, 50.30, 101.23].asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: false,
              barWidth: 0.5,
              color: AppColors.kViolate,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 1,
                    color: Colors.white,
                    strokeWidth: 1,
                    strokeColor: Colors.yellow,
                  );
                },
              ),
            ),
          ],
          minY: 20,
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            checkToShowHorizontalLine: (value) => value % 1 == 0,
          ),
          titlesData: getTitlesData(),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(
                color: Colors.black,
              ),
              bottom: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipMargin: 0,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '${barSpot.y.toString()} %',
                    AppStyles.c656262W400S16,
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  FlTitlesData getTitlesData() {
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: rSize * 0.045,
          getTitlesWidget: (value, meta) {
            if (value % 1 != 0) {
              return Container();
            }

            var fitInsideLeftTitle = false;
            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 10,
              fitInside: fitInsideLeftTitle ? SideTitleFitInsideData.fromTitleMeta(meta, distanceFromEdge: 0) : SideTitleFitInsideData.disable(),
              child: Text('${value}', textAlign: TextAlign.center),
            );
          },
          interval: 20,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          getTitlesWidget: (value, meta) {
            if (value % 1 != 0) {
              return Container();
            }
            return SideTitleWidget(
              space: 15,
              axisSide: meta.axisSide,
              child: Text(
                ['2024-08-02', '2024-08-03', '2024-08-03'][value.toInt()],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget columnChart() {
    return SizedBox(
      height: rSize * 0.2,
      child: Row(
        children: [
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              // title: ChartTitle(
              //   text: 'syncfusion_flutter_charts\ncolumn & candle',
              //   textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // ),
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelRotation: 45,
                initialVisibleMaximum: 3,
                // visibleMaximum: 3,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}%',
                majorTickLines: const MajorTickLines(size: 0),
                interval: 20,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enablePanning: true,
              ),
              series: _getDefaultColumnSeries(),
              // tooltipBehavior: _tooltipBehavior,
              // trackballBehavior: _trackballBehavior,
            ),
          ),
          if (['Cash', 'Future', 'Options'].length > 4) ...[
            const SizedBox(width: 2),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.kTextFieldInput,
            ),
          ],
        ],
      ),
    );
  }

  List<CartesianSeries> _getDefaultColumnSeries() {
    return <CartesianSeries>[
      ColumnSeries<String, String>(
        dataSource: ['Cash', 'Future', 'Options'],
        xValueMapper: (String label, _) => label,
        yValueMapper: (String label, int index) => [10, 2000, 501][index],
        pointColorMapper: (String label, int index) => Color(0xFFC8C8C8),
        name: 'ColumnSeries',
        color: Color(0xFFFFFFFF),
        // FlutterFlowTheme.of(context).alternate,
        dataLabelSettings: DataLabelSettings(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
          isVisible: false,
          labelIntersectAction: LabelIntersectAction.none,
          borderWidth: 0,
          builder: (data, point, series, dataIndex, seriesIndex) {
            final value = double.tryParse('${[10, 2000, 501][dataIndex]}') ?? 0;
            return Padding(
              padding: EdgeInsets.only(bottom: value >= 0 ? 0 : 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$value%', style: TextStyle(fontSize: 12)),
                  if (value != 0)
                    Icon(
                      value > 0 ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                      color: value > 0 ? Colors.green : Colors.red,
                      size: 18,
                    ),
                ],
              ),
            );
          },
        ),
      ),
      if (/*showSecondColumn()*/ true)
        ColumnSeries<String, String>(
          dataSource: ['Cash', 'Future', 'Options'],
          xValueMapper: (String label, _) => label,
          yValueMapper: (String label, int index) => [10, 2000, 501][index],
          pointColorMapper: (String label, int index) => Colors.green,
          name: 'ColumnSeries',
          color: Color(0xFFFFFFFF), //FlutterFlowTheme.of(context).alternate,
        ),
    ];
  }
}
