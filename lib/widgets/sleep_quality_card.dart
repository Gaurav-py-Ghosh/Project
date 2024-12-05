import 'package:flutter/material.dart';

class SleepQualityCard extends StatelessWidget {
  const SleepQualityCard({super.key});

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
        elevation: 2,
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
                  Icon(Icons.bedtime, color: Colors.purple.shade200),
                  const SizedBox(width: 8),
                  const Text(
                    'Sleep Quality',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.purple.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurple.shade300,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '8h 12m',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'Good',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
