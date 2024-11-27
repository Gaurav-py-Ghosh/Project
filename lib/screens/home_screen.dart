  import 'package:flutter/material.dart';
  import 'package:flutter_animate/flutter_animate.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:flutter_svg/flutter_svg.dart';

  import '../widgets/activity_progress_card.dart';
  import '../widgets/heart_rate_card.dart';
  import '../widgets/sleep_quality_card.dart';
  import 'package:fl_chart/fl_chart.dart';

  void main() {
    runApp(const MyApp());
  }

  class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
      super.initState();
      // Navigate to HomeScreen after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Medical cross icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.local_hospital,
                  size: 80,
                  color: Color(0xFF329D9C),
                ),
              )
                  .animate()
                  .scale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              )
                  .then()
                  .shimmer(
                duration: const Duration(seconds: 2),
                color: Colors.white.withOpacity(0.3),
              ),

              const SizedBox(height: 40),

              // App name
              Text(
                'HealthTracker',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .fadeIn(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 500),
              ),

              const SizedBox(height: 16),

              // Tagline
              Text(
                'Your Personal Health Companion',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              )
                  .animate()
                  .fadeIn(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
              ),

              const SizedBox(height: 60),

              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              )
                  .animate()
                  .fadeIn(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 500),
              ),
            ],
          ),
        ),
      );
    }
  }

  class ActivityScreen extends StatelessWidget {
    const ActivityScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Activity Tracking'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const StepCountCard()
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideX(),
                  const SizedBox(height: 16),
                  const WeeklyActivityChart()
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(),
                  const SizedBox(height: 16),
                  const ActivityGoalsCard()
                      .animate()
                      .fadeIn(delay: 600.ms)
                      .slideX(),
                ]),
              ),
            ),
          ],
        ),
      );
    }
  }

  class StepCountCard extends StatelessWidget {
    const StepCountCard({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Steps',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '8,459',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  CircularProgressIndicator(
                    value: 0.85,
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    strokeWidth: 8,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: 0.85,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              const SizedBox(height: 8),
              Text(
                '85% of daily goal',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }
  }

  class WeeklyActivityChart extends StatelessWidget {
    const WeeklyActivityChart({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Activity',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 12000,
                    barGroups: _getBarGroups(),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Text(
                              days[value.toInt()],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<BarChartGroupData> _getBarGroups() {
      final data = [8500, 7200, 9300, 8700, 10200, 7800, 8459];
      return List.generate(
        7,
            (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: data[index].toDouble(),
              color: index == 6 ? Colors.blue : Colors.blue.withOpacity(0.5),
              width: 20,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ],
        ),
      );
    }
  }

  class ActivityGoalsCard extends StatelessWidget {
    const ActivityGoalsCard({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity Goals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _buildGoalItem(
                context,
                icon: Icons.directions_walk,
                title: 'Daily Steps',
                progress: 0.85,
                current: '8,459',
                goal: '10,000',
              ),
              const SizedBox(height: 16),
              _buildGoalItem(
                context,
                icon: Icons.local_fire_department,
                title: 'Calories Burned',
                progress: 0.7,
                current: '420',
                goal: '600',
              ),
              const SizedBox(height: 16),
              _buildGoalItem(
                context,
                icon: Icons.timer,
                title: 'Active Minutes',
                progress: 0.6,
                current: '45',
                goal: '75',
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildGoalItem(
        BuildContext context, {
          required IconData icon,
          required String title,
          required double progress,
          required String current,
          required String goal,
        }) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                const SizedBox(height: 4),
                Text(
                  '$current / $goal',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF329D9C),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const HomeScreen(),
      );
    }
  }

  class SleepScreen extends StatelessWidget {
    const SleepScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sleep'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: CustomScrollView(
          slivers: [

            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const LastNightSleepCard()
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideX(),
                  const SizedBox(height: 16),
                  const WeeklySleepChart()
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(),
                  const SizedBox(height: 16),
                  const SleepQualityMetrics()
                      .animate()
                      .fadeIn(delay: 600.ms)
                      .slideX(),
                ]),
              ),
            ),
          ],
        ),
      );
    }
  }

  class LastNightSleepCard extends StatelessWidget {
    const LastNightSleepCard({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Night\'s Sleep',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.nightlight_round, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Text(
                            '7h 45m',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Good',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSleepMetric(
                    context,
                    icon: Icons.bedtime,
                    label: 'Bedtime',
                    value: '10:30 PM',
                  ),
                  _buildSleepMetric(
                    context,
                    icon: Icons.call,
                    label: 'Wake up',
                    value: '6:15 AM',
                  ),
                  _buildSleepMetric(
                    context,
                    icon: Icons.auto_graph,
                    label: 'Efficiency',
                    value: '92%',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildSleepMetric(
        BuildContext context, {
          required IconData icon,
          required String label,
          required String value,
        }) {
      return Column(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );
    }
  }

  class WeeklySleepChart extends StatelessWidget {
    const WeeklySleepChart({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Sleep Pattern',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Text(
                              days[value.toInt()],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 7.5),
                          FlSpot(1, 6.8),
                          FlSpot(2, 8.0),
                          FlSpot(3, 7.2),
                          FlSpot(4, 7.8),
                          FlSpot(5, 8.5),
                          FlSpot(6, 7.75),
                        ],
                        isCurved: true,
                        color: Theme.of(context).primaryColor,
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                      ),
                    ],
                    minY: 6,
                    maxY: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  class SleepQualityMetrics extends StatelessWidget {
    const SleepQualityMetrics({super.key});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sleep Quality Metrics',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _buildQualityMetric(
                context,
                icon: Icons.bed,
                title: 'Deep Sleep',
                value: '2h 15m',
                percentage: 0.75,
              ),
              const SizedBox(height: 16),
              _buildQualityMetric(
                context,
                icon: Icons.remove_red_eye,
                title: 'REM Sleep',
                value: '1h 45m',
                percentage: 0.65,
              ),
              const SizedBox(height: 16),
              _buildQualityMetric(
                context,
                icon: Icons.waves,
                title: 'Sleep Consistency',
                value: '85%',
                percentage: 0.85,
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildQualityMetric(
        BuildContext context, {
          required IconData icon,
          required String title,
          required String value,
          required double percentage,
        }) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    int _currentIndex = 0;
    final _pageController = PageController();

    final List<Widget> _screens = [
      const HomeContent(),
      const ActivityScreen(),
      const SleepScreen(),
      const DiseasePredictionScreen(),
    ];

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: _screens,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() => _currentIndex = index);
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.insert_chart_outlined),
                      selectedIcon: Icon(Icons.insert_chart),
                      label: 'Activity',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bedtime_outlined),
                      selectedIcon: Icon(Icons.bedtime),
                      label: 'Sleep',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.medical_services_outlined),
                      selectedIcon: Icon(Icons.medical_services),
                      label: 'Health',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  class HomeContent extends StatelessWidget {
    const HomeContent({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const UserHeader(),
                    const SizedBox(height: 16),
                    const ActivityProgressCard()
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideX(),
                    const SizedBox(height: 16),
                    const HeartRateCard()
                        .animate()
                        .fadeIn(delay: 400.ms)
                        .slideX(),
                    const SizedBox(height: 16),
                    const SleepQualityCard()
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideX(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  class UserHeader extends StatelessWidget {
    const UserHeader({super.key});

    @override
    Widget build(BuildContext context) {
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                'John Doe',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ).animate().fade().scale();
    }
  }

  class DiseasePredictionScreen extends StatefulWidget {
    const DiseasePredictionScreen({super.key});

    @override
    State<DiseasePredictionScreen> createState() => _DiseasePredictionScreenState();
  }

  class _DiseasePredictionScreenState extends State<DiseasePredictionScreen> {
    final List<String> _selectedSymptoms = [];
    String _predictionResult = "";
    String _severity = "";
    Color _severityColor = Colors.grey;
    bool _isAnalyzing = false;

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
      setState(() => _isAnalyzing = true);

      Future.delayed(const Duration(seconds: 1), () {
        final symptoms = _selectedSymptoms.map((s) => s.toLowerCase()).toList();

        if (symptoms.contains('fever') &&
            symptoms.contains('cough') &&
            symptoms.contains('shortness of breath')) {
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
        } else if (symptoms.contains('sore throat') &&
            symptoms.contains('runny nose')) {
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
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Your Symptoms',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Choose all symptoms that apply:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
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
                                  selectedColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  checkmarkColor: Theme.of(context).primaryColor,
                                ).animate().scale(
                                  duration: const Duration(milliseconds: 200),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn().slideY(),
                    const SizedBox(height: 20),
                    Center(
                      child: FilledButton.icon(
                        onPressed: _selectedSymptoms.isNotEmpty && !_isAnalyzing
                            ? _predictDisease
                            : null,
                        icon: _isAnalyzing
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Icon(Icons.search_rounded),
                        label: const Text('Analyze Symptoms'),
                      ),
                    ).animate().fadeIn(delay: 200.ms).scale(),
                    if (_predictionResult.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Card(
                        color: _severityColor.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prediction Result:',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _predictionResult,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Severity: $_severity',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: _severityColor),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideY(),
                    ],
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  class ResultCard extends StatelessWidget {
    final String predictionResult;
    final String severity;
    final Color severityColor;

    const ResultCard({
      super.key,
      required this.predictionResult,
      required this.severity,
      required this.severityColor,
    });

    @override
    Widget build(BuildContext context) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.medical_services,
                      color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Analysis Result',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                predictionResult,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (severity.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Severity: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: severityColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        severity,
                        style: TextStyle(
                          color: severityColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              const DisclaimerText(),
            ],
          ),
        ),
      );
    }
  }

  class DisclaimerText extends StatelessWidget {
    const DisclaimerText({super.key});

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 16,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'This is not a medical diagnosis. Please consult a healthcare provider for proper medical advice.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }