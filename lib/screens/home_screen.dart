  import 'package:flutter/material.dart';
  import 'package:flutter_animate/flutter_animate.dart';
  import 'package:google_fonts/google_fonts.dart';
  // import 'package:flutter_svg/flutter_svg.dart';
  import 'package:http/http.dart' as http;
  import 'package:html/parser.dart' as parser;
  import '../widgets/activity_progress_card.dart';
  import '../widgets/heart_rate_card.dart';
  import '../widgets/sleep_quality_card.dart';
  import 'package:fl_chart/fl_chart.dart';
  import 'dart:convert';
  import 'package:syncfusion_flutter_gauges/gauges.dart';

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
              padding: const EdgeInsets.only(top:16,left:16,right:16,bottom:100),
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
              padding: const EdgeInsets.only(top:16,left:16,right:16,bottom:100),
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
                    icon: Icons.sunny,
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




  class PatientHistoryScreen extends StatelessWidget {
    const PatientHistoryScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Patient History'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top:16.0,left:16,right:16,bottom:100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionTitle(context, 'Past Medications'),
                    _buildHistoryItem(context, 'Medication A - 10mg - 2022-01-01'),
                    _buildHistoryItem(context, 'Medication B - 20mg - 2022-02-15'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(context, 'Accidents'),
                    _buildHistoryItem(context, 'Fall - 2021-12-10'),
                    _buildHistoryItem(context, 'Car Accident - 2022-03-05'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(context, 'Allergies'),
                    _buildHistoryItem(context, 'Peanuts'),
                    _buildHistoryItem(context, 'Penicillin'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(context, 'MRIs and Scans'),
                    _buildScanItem(context, 'MRI - Brain - 2023-01-20', 'assets/images/mri_brain.jpg'),
                    _buildScanItem(context, 'X-Ray - Chest - 2023-02-15', 'assets/images/xray_chest.jpg'),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildSectionTitle(BuildContext context, String title) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold) ??
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), // Fallback style
        ),
      );
    }

    Widget _buildHistoryItem(BuildContext context, String item) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(item, style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle()),
        ),
      );
    }

    Widget _buildScanItem(BuildContext context, String title, String imagePath) {
      return GestureDetector(
        onTap: () => _showImageDialog(context, imagePath),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle()),
                const SizedBox(height: 8),
                Text('Tap to view image', style: Theme.of(context).textTheme.bodySmall ?? const TextStyle()),
              ],
            ),
          ),
        ),
      );
    }

    void _showImageDialog(BuildContext context, String imagePath) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Image.asset(imagePath, fit: BoxFit.cover),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
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
      const PatientHistoryScreen(),

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
                    NavigationDestination(
                      icon: Icon(Icons.history_outlined),
                      selectedIcon: Icon(Icons.history),
                      label: 'History',
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
                padding: const EdgeInsets.only(top:16,left:16,right:16,bottom:100),
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
                'Sejal Gupta',
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
    Widget? _resultCard;
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

      // Reset result card while analyzing
      setState(() => _resultCard = null);

      Future.delayed(const Duration(seconds: 1), () {
        if (_selectedSymptoms.isNotEmpty) {
          _fetchDiseaseData(_selectedSymptoms);
        } else {
          _showResult(
            "Please select your symptoms.",
            "",
            Colors.grey,
          );
        }
      });
    }

    Future<void> _fetchDiseaseData(List<String> symptoms) async {
      try {
        //CONNECTION TO API
        final symptomQuery = Uri.encodeComponent(symptoms.join(' OR '));
        final url = 'https://api.fda.gov/drug/event.json?search=symptom:$symptomQuery&limit=5';

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final diseases = _parseDiseaseData(data);

          if (diseases.isNotEmpty) {
            _showResult(
              "Possible Conditions: ${diseases.join(', ')}",
              "Consult a healthcare provider",
              Colors.blue,
            );
          } else {
            _showResult(
              "No conditions found for the selected symptoms.",
              "Undetermined",
              Colors.grey,
            );
          }
        } else {
          _showResult(
            "Failed to fetch data. Please try again later.",
            "",
            Colors.grey,
          );
        }
      } catch (e) {
        _showResult(
          "Unable to analyze symptoms at this time. Please try again later.",
          "",
          Colors.grey,
        );
      }
    }

    List<String> _parseDiseaseData(Map<String, dynamic> data) {
      final Set<String> diseases = {};

      try {
        if (data['results'] != null) {
          for (var event in data['results']) {
            if (event['patient'] != null &&
                event['patient']['reaction'] != null) {
              for (var reaction in event['patient']['reaction']) {
                final reactionName = reaction['reactionmeddrapt'];
                if (reactionName != null && reactionName is String) {
                  diseases.add(reactionName);
                }
              }
            }
          }
        }
      } catch (e) {
        print('Error parsing disease data: $e');
      }

      return diseases.take(2).toList();
    }

    void _showResult(String prediction, String severity, Color color) {
      setState(() {
        _resultCard = ResultCard(
          predictionResult: prediction,
          severity: severity,
          severityColor: color,
        );
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
                padding: const EdgeInsets.all(16.0),
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
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _commonSymptoms.map((symptom) {
                                return FilterChip(
                                  label: Text(symptom),
                                  selected: _selectedSymptoms.contains(symptom),
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedSymptoms.add(symptom);
                                      } else {
                                        _selectedSymptoms.remove(symptom);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isAnalyzing ? null : _predictDisease,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isAnalyzing ? Colors.deepPurple.shade300 : Colors.deepPurple.shade400, // Button background color
                                  foregroundColor: Colors.white, // Text color
                                  disabledBackgroundColor: Colors.deepPurple.shade300,
                                  disabledForegroundColor: Colors.white,// Disabled background color
                                  padding: const EdgeInsets.symmetric(vertical: 12), // Padding inside the button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // Rounded corners
                                  ),
                                ),
                                child: Text(
                                  _isAnalyzing ? 'Analyzing...' : 'Predict Disease',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            if (_resultCard != null) _resultCard!,
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // ... (previous code remains the same until ResultCard class)

  class ResultCard extends StatelessWidget {
    final String predictionResult;
    final String severity;
    final Color severityColor;

    const ResultCard({
      super.key,
      required this.predictionResult,
      this.severity = '', // Provide default empty string
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
              // if (severity.isNotEmpty) ...[
              //   const SizedBox(height: 8),
              //   Row(
              //     children: [
              //       Text(
              //         'Severity: ',
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodyMedium
              //             ?.copyWith(fontWeight: FontWeight.bold),
              //       ),
              //       Container(
              //         padding:
              //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //         decoration: BoxDecoration(
              //           color: severityColor.withOpacity(0.2),
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: Text(
              //           severity,
              //           style: TextStyle(
              //             color: severityColor,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
              const SizedBox(height: 12),
              const DisclaimerText(),
            ],
          ),
        ),
      );
    }
  }

  // ... (rest of the code remains the same)

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
            const SizedBox(width: 10),
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