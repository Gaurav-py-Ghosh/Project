import 'package:flutter/material.dart';
import '../widgets/activity_progress_card.dart';
import '../widgets/heart_rate_card.dart';
import '../widgets/sleep_quality_card.dart';
import 'dart:math';

// Main Home Screen with Bottom Navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(), // Main home content screen
    const ActivityScreen(), // Activity screen content
    const SleepScreen(), // Sleep screen content
    const DiseasePredictionScreen(), // Disease prediction screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF329D9C),
        title: const Text('Home Screen'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime),
            label: 'Sleep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home content screen
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeader(),
            SizedBox(height: 20),
            ActivityProgressCard(),
            SizedBox(height: 20),
            HeartRateCard(),
            SizedBox(height: 20),
            SleepQualityCard(),
          ],
        ),
      ),
    );
  }
}

// User header widget
class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.person, color: Colors.blue),
        ),
        const SizedBox(width: 11),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

// Activity screen
class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Activity Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Sleep screen
class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Sleep Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class DiseasePredictionScreen extends StatefulWidget {
  const DiseasePredictionScreen({super.key});

  @override
  _DiseasePredictionScreenState createState() => _DiseasePredictionScreenState();
}

class _DiseasePredictionScreenState extends State<DiseasePredictionScreen> {
  final List<String> _selectedSymptoms = [];
  String _predictionResult = "";
  String _severity = "";
  Color _severityColor = Colors.grey;
  bool _isAnalyzing = false;

  // Predefined list of common symptoms
  final List<String> _commonSymptoms = [
    'Fever',
    'Cough',
    'Headache',
    'Fatigue',
    'Sore Throat',
    'Shortness of Breath',
    'Muscle Pain',
    'Nausea',
    'Dizziness',
    'Loss of Appetite',
    'Chest Pain',
    'Runny Nose',
  ];

  void _predictDisease() {
    setState(() {
      _isAnalyzing = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      final symptoms = _selectedSymptoms.map((s) => s.toLowerCase()).toList();

      // Enhanced prediction logic
      if (symptoms.contains('fever') && symptoms.contains('cough') && symptoms.contains('shortness of breath')) {
        _updatePrediction(
          "Possible Condition: Respiratory Infection",
          "Moderate to Severe",
          Colors.red,
        );
      } else if (symptoms.contains('fever') && symptoms.contains('cough')) {
        _updatePrediction(
          "Possible Condition: Influenza (Flu)",
          "Moderate",
          Colors.orange,
        );
      } else if (symptoms.contains('headache') && symptoms.contains('nausea')) {
        _updatePrediction(
          "Possible Condition: Migraine",
          "Mild to Moderate",
          Colors.yellow[700]!,
        );
      } else if (symptoms.contains('sore throat') && symptoms.contains('runny nose')) {
        _updatePrediction(
          "Possible Condition: Common Cold",
          "Mild",
          Colors.green,
        );
      } else if (symptoms.isNotEmpty) {
        _updatePrediction(
          "Multiple symptoms detected. Please consult a healthcare provider for accurate diagnosis.",
          "Undetermined",
          Colors.grey,
        );
      } else {
        _updatePrediction(
          "Please select your symptoms.",
          "",
          Colors.grey,
        );
      }
    });
  }

  void _updatePrediction(String prediction, String severity, Color color) {
    setState(() {
      _predictionResult = prediction;
      _severity = severity;
      _severityColor = color;
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
        backgroundColor: Color(0xFF329D9C),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF329D9C)!, Colors.white],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Your Symptoms',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose all symptoms that apply:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _commonSymptoms.map((symptom) {
                          final isSelected = _selectedSymptoms.contains(symptom);
                          return FilterChip(
                            label: Text(symptom),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedSymptoms.add(symptom);
                                } else {
                                  _selectedSymptoms.remove(symptom);
                                }
                              });
                            },
                            selectedColor: Colors.blue[100],
                            checkmarkColor: Colors.blue[800],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _selectedSymptoms.isNotEmpty ? _predictDisease : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedSymptoms.isNotEmpty
                        ? const Color(0xFF329D9C) // Change this color to any desired color
                        : Colors.black, // Optional: Disabled button color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isAnalyzing
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Analyze Symptoms',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              if (_predictionResult.isNotEmpty)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.medical_services, color: Color(0xFF329D9C)),
                            const SizedBox(width: 8),
                            const Text(
                              'Analysis Result',
                              style: TextStyle(

                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _predictionResult,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (_severity.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'Severity: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _severityColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _severity,
                                  style: TextStyle(
                                    color: _severityColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 12),
                        const Text(
                          'Disclaimer: This is not a medical diagnosis. Please consult a healthcare provider for proper medical advice.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
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