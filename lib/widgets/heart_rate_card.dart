import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HeartRateCard extends StatelessWidget {
  const HeartRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff40097c),
            Color(0xff7e4db6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        color: Colors.transparent, // Make the card transparent
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.purple.shade100),
                  const SizedBox(width: 8),
                  const Text(
                    'Heart Rate',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 80),
                          const FlSpot(1, 85),
                          const FlSpot(2, 75),
                          const FlSpot(3, 82),
                          const FlSpot(4, 78),
                          const FlSpot(5, 84),
                        ],
                        isCurved: true,
                        color: Colors.deepPurple.shade400,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.purple.shade100.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
