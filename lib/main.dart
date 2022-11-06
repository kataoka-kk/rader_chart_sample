import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RadarChartSample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RadarChartSample(),
    );
  }
}

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

class RadarChartSample extends StatelessWidget {
  const RadarChartSample({Key? key}) : super(key: key);

  final selectedDataSetIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RadarChart確認用'),
      ),
      body: RadarChart(
        RadarChartData(
          // グラフとタイトルの距離（デフォルト0.2,0.0<=x<=1.0）
          titlePositionPercentageOffset: 0.1,
          // tickCountによってtickBorderDataのBorder数が変わる。tickCountは偶数がいいと思われる
          // tickCount: null,
          tickBorderData: const BorderSide(color: Colors.transparent),
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          getTitle: (index, angle) => showingChartTitle(index),
          dataSets: showingDataSets(),
          // radarBorderData はレーダーチャートの外線のカスタマイズができる
          // radarBorderData: const BorderSide(color: Colors.transparent),
          // radarShape はレーダーチャートの外線の形を変更できる。円と〇角形は簡単に変更できる。
          radarShape: RadarShape.polygon,
        ),
      ),
    );
  }

  RadarChartTitle showingChartTitle(index) {
    switch (index) {
      case 0:
        return const RadarChartTitle(
          text: 'Mobile or Tablet',
          // angle: usedAngle,
          angle: 0,
        );
      case 1:
        return const RadarChartTitle(text: 'TV');
      case 2:
        return const RadarChartTitle(text: 'Desktop');
      case 3:
        return const RadarChartTitle(text: 'Web');
      case 4:
        return const RadarChartTitle(text: 'Other');
      default:
        return const RadarChartTitle(text: '');
    }
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        // グラフの線で囲われている中身の色(動的に変更できるようになっている)
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.4)
            : rawDataSet.color.withOpacity(0.05),
        // グラフの線の色
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),

        // グラフの頂点の円の大きさ
        // entryRadius: isSelected ? 3 : 2,
        // グラフの辺の大きさ
        // borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Fashion',
        color: fashionColor,
        values: [
          200,
          200,
          200,
          200,
          200,
        ],
      ),
      RawDataSet(
        title: 'Art & Tech',
        color: artColor,
        values: [
          250,
          100,
          200,
          0,
          150,
        ],
      ),
      // RawDataSet(
      //   title: 'Entertainment',
      //   color: entertainmentColor,
      //   values: [
      //     200,
      //     150,
      //     50,
      //   ],
      // ),
      // RawDataSet(
      //   title: 'Off-road Vehicle',
      //   color: offRoadColor,
      //   values: [
      //     150,
      //     200,
      //     150,
      //   ],
      // ),
      // RawDataSet(
      //   title: 'Boxing',
      //   color: boxingColor,
      //   values: [
      //     100,
      //     250,
      //     100,
      //   ],
      // ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}
