import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class buildLineChart extends StatefulWidget {
  final List<FlSpot> curve1;
  final List<FlSpot> curve2;
  final List<FlSpot> curve3;
  final List<FlSpot> curve4;
  final List<String> productNames;

  const buildLineChart({
    super.key,
    required this.curve1,
    required this.curve2,
    required this.curve3,
    required this.curve4,
    required this.productNames,
  });

  @override
  State<buildLineChart> createState() => _buildLineChartState();
}

class _buildLineChartState extends State<buildLineChart> {
  late List<FlSpot> curve1, curve2, curve3, curve4;
  double dotX1 = 1, dotX2 = 2, dotX3 = 3, dotX4 = 0;
  int? activeDotIndex;
  late List<String> productNames;

  final GlobalKey chartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    curve1 = widget.curve1.isNotEmpty ? widget.curve1 : [FlSpot(0, 0)];
    curve2 = widget.curve2.isNotEmpty ? widget.curve2 : [FlSpot(0, 0)];
    curve3 = widget.curve3.isNotEmpty ? widget.curve3 : [FlSpot(0, 0)];
    curve4 = widget.curve4.isNotEmpty ? widget.curve4 : [FlSpot(0, 0)];
    productNames = widget.productNames;
  //   print("LineChart Product Names: $productNames");
  //   print("LineChart initState Curves: $curve1, $curve2, $curve3, $curve4");
   }

  @override
  void didUpdateWidget(buildLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.curve1 != widget.curve1 ||
        oldWidget.curve2 != widget.curve2 ||
        oldWidget.curve3 != widget.curve3 ||
        oldWidget.curve4 != widget.curve4 ||
        oldWidget.productNames != widget.productNames) {
      setState(() {
        curve1 = widget.curve1.isNotEmpty ? widget.curve1 : [FlSpot(0, 0)];
        curve2 = widget.curve2.isNotEmpty ? widget.curve2 : [FlSpot(0, 0)];
        curve3 = widget.curve3.isNotEmpty ? widget.curve3 : [FlSpot(0, 0)];
        curve4 = widget.curve4.isNotEmpty ? widget.curve4 : [FlSpot(0, 0)];
        productNames = widget.productNames;
        // print("LineChart didUpdateWidget Product Names: $productNames");
        // print("LineChart didUpdateWidget Curves: $curve1, $curve2, $curve3, $curve4");
      });
    }
  }

  double getYatX(double x, List<FlSpot> curve) {
    for (int i = 0; i < curve.length - 1; i++) {
      final left = curve[i];
      final right = curve[i + 1];
      if (x >= left.x && x <= right.x) {
        final t = (x - left.x) / (right.x - left.x);
        return left.y + t * (right.y - left.y);
      }
    }
    return curve.last.y;
  }

  void _onPanStart(Offset localPos, BoxConstraints constraints) {
    final chartWidth = constraints.maxWidth;
    final positions = [dotX1, dotX2, dotX3, dotX4];
    final distances = positions
        .map((dotX) => (localPos.dx - (dotX / 3 * chartWidth)).abs())
        .toList();
    setState(() {
      activeDotIndex =
          distances.indexOf(distances.reduce((a, b) => a < b ? a : b));
    });
  }

  void _onPanUpdate(Offset localPos, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final newX = (localPos.dx / width * 3).clamp(0.0, 3.0);
    setState(() {
      switch (activeDotIndex) {
        case 0:
          dotX1 = newX;
          break;
        case 1:
          dotX2 = newX;
          break;
        case 2:
          dotX3 = newX;
          break;
        case 3:
          dotX4 = newX;
          break;
      }
    });
  }

  LineChartBarData _buildDraggableDot(double x, double y, Color strokeColor) {
    return LineChartBarData(
      spots: [FlSpot(x, y)],
      isCurved: false,
      barWidth: 0,
      dotData: FlDotData(
        show: true,
        getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
          radius: 4,
          color: Colors.white,
          strokeWidth: 4,
          strokeColor: strokeColor,
        ),
      ),
    );
  }

  Widget _buildTooltip({
    required double dx,
    required double dy,
    required String productName,
    required Color color,
  }) {
    final renderBox = chartKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return const SizedBox.shrink();

    final size = renderBox.size;
    final chartWidth = size.width;
    final chartHeight = size.height;

    final xPixel = (dx / 3) * chartWidth;
    final yPixel = chartHeight - ((dy / 55) * chartHeight);

    return Positioned(
      left: (xPixel - 50).clamp(0.0, chartWidth - 100),
      top: (yPixel - 60).clamp(0.0, chartHeight - 60),
      child: Container(
        width: 120,
        // padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 1),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 28,
              decoration: BoxDecoration(
                  color: color
              ),
              child: Text(
                "Week ${dx.round() + 1}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: CircleAvatar(radius: 3, backgroundColor: color),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    productName,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'Quantity: ${dy.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 11, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [const Color(0xFF6D00FA), const Color(0xffE047CE)],
      [const Color(0xffD4B687), const Color(0xffE14D4D)],
      [const Color(0xff95D487), const Color(0xffFFD95D)],
      [const Color(0xff68ACBE), const Color(0xff2E70FE)],
    ];

    final dotY1 = getYatX(dotX1, curve1);
    final dotY2 = getYatX(dotX2, curve2);
    final dotY3 = getYatX(dotX3, curve3);
    final dotY4 = getYatX(dotX4, curve4);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: (details) {
            final box = context.findRenderObject() as RenderBox;
            final localPos = box.globalToLocal(details.globalPosition);
            _onPanStart(localPos, constraints);
          },
          onPanUpdate: (details) {
            final box = context.findRenderObject() as RenderBox;
            final localPos = box.globalToLocal(details.globalPosition);
            _onPanUpdate(localPos, constraints);
          },
          onPanEnd: (_) => setState(() => activeDotIndex = null),
          child: SizedBox(
            height: 280,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16,left: 8),
                      child: LineChart(
                        key: chartKey,
                        LineChartData(
                          clipData: FlClipData.all(),
                          minX: 0,
                          maxX: 3,
                          minY: 0,
                          maxY: 55,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 5,
                            getDrawingHorizontalLine: (_) => FlLine(
                              color: Colors.grey.withOpacity(0.4),
                              strokeWidth: 1.4,
                              dashArray: [4, 4],
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                reservedSize: 35,
                                getTitlesWidget: (value, _) => Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, _) {
                                  const labels = [
                                    "     Week 1",
                                    "Week 2",
                                    "Week 3",
                                    "Week 4     "
                                  ];
                                  if (value >= 0 && value < labels.length) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        labels[value.toInt()],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          lineTouchData: LineTouchData(enabled: false),
                          lineBarsData: [
                            if (curve1.length > 1)
                              LineChartBarData(
                                spots: curve1,
                                isCurved: false,
                                barWidth: 4,
                                gradient: LinearGradient(colors: gradients[0]),
                                dotData: FlDotData(show: false),
                              ),
                            if (curve2.length > 1)
                              LineChartBarData(
                                spots: curve2,
                                isCurved: false,
                                barWidth: 4,
                                gradient: LinearGradient(colors: gradients[1]),
                                dotData: FlDotData(show: false),
                              ),
                            if (curve3.length > 1)
                              LineChartBarData(
                                spots: curve3,
                                isCurved: false,
                                barWidth: 4,
                                gradient: LinearGradient(colors: gradients[2]),
                                dotData: FlDotData(show: false),
                              ),
                            if (curve4.length > 1)
                              LineChartBarData(
                                spots: curve4,
                                isCurved: false,
                                barWidth: 4,
                                gradient: LinearGradient(colors: gradients[3]),
                                dotData: FlDotData(show: false),
                              ),
                            if (curve1.length > 1)
                              _buildDraggableDot(dotX1, dotY1, gradients[0][0]),
                            if (curve2.length > 1)
                              _buildDraggableDot(dotX2, dotY2, gradients[1][0]),
                            if (curve3.length > 1)
                              _buildDraggableDot(dotX3, dotY3, gradients[2][0]),
                            if (curve4.length > 1)
                              _buildDraggableDot(dotX4, dotY4, gradients[3][0]),
                          ],                        ),
                      ),
                    ),
                  ),
                ),

                // Tooltips
                if (curve1.length > 1 && productNames[0].isNotEmpty)
                  _buildTooltip(
                    dx: dotX1,
                    dy: dotY1,
                    productName: productNames[0],
                    color: gradients[0][0],
                  ),
                if (curve2.length > 1 && productNames[1].isNotEmpty)
                  _buildTooltip(
                    dx: dotX2,
                    dy: dotY2,
                    productName: productNames[1],
                    color: gradients[1][0],
                  ),
                if (curve3.length > 1 && productNames[2].isNotEmpty)
                  _buildTooltip(
                    dx: dotX3,
                    dy: dotY3,
                    productName: productNames[2],
                    color: gradients[2][0],
                  ),
                if (curve4.length > 1 && productNames[3].isNotEmpty)
                  _buildTooltip(
                    dx: dotX4,
                    dy: dotY4,
                    productName: productNames[3],
                    color: gradients[3][0],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
