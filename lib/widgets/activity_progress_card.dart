import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ActivityProgressCard extends StatelessWidget {
  final double progressValue;

  const ActivityProgressCard({super.key, this.progressValue = 65});

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
        color: Colors.transparent, // Transparent to show the gradient
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Daily Activity Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            showLabels: false,
                            showTicks: false,
                            minimum: 0,
                            maximum: 100,
                            axisLineStyle: const AxisLineStyle(
                              thickness: 0.15,
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: progressValue,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve,
                                gradient: const SweepGradient(
                                  colors: <Color>[
                                    Color(0xFFB97CFF),
                                    Color(0xffd2acff)
                                  ],
                                  stops: <double>[0.25, 0.75],
                                ),
                              ),
                              MarkerPointer(
                                value: progressValue,
                                markerType: MarkerType.circle,
                                color: const Color(0xffb97cff),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${progressValue.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const Text(
                          'Completed',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
