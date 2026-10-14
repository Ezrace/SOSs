import 'package:flutter/material.dart';

void main() {
  runApp(const SOSsApp());
}

class SOSsApp extends StatelessWidget {
  const SOSsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOSs',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFA1304B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F6),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6DCE4),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.home_rounded,
                      color: Color(0xFFA1304B),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOSs',
                          style: TextStyle(
                            fontSize: 22,
                            height: 1,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4A2631),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'A calmer space, together',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF765D64),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Settings',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SupportPreferencesScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.tune_rounded,
                      color: Color(0xFF765D64),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 190,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ExcludeSemantics(
                        child: CustomPaint(painter: _CalmLandscapePainter()),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 14, right: 92),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello!',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4A2631),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'How are you feeling today?',
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A2631),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Take a breath. We can take this one step at a time.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.35,
                              color: Color(0xFF765D64),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _SOSButton(
                label: 'SOS / Calm',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectNeedScreen()),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _SecondaryActionButton(
                      label: 'My Support',
                      detail: 'Preferences',
                      icon: Icons.favorite_outline_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SupportPreferencesScreen(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SecondaryActionButton(
                      label: 'History',
                      detail: 'Past events',
                      icon: Icons.schedule_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _HomeBottomNav(
        onSupport: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SupportPreferencesScreen()),
        ),
        onHistory: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HistoryScreen()),
        ),
      ),
    );
  }
}

class SelectNeedScreen extends StatelessWidget {
  const SelectNeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        _needLabel('Too noisy'),
        const Color(0xFF8F9DFF),
        'sound is overwhelming',
      ),
      (
        _needLabel('Too bright'),
        const Color(0xFFFFD27D),
        'lighting is too intense',
      ),
      (
        _needLabel('Too crowded'),
        const Color(0xFF77C4B6),
        'too much stimulation around me',
      ),
      (
        _needLabel('I need space'),
        const Color(0xFFEE8FA6),
        'distance and quiet would help',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('What do you need?'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tap the option that best describes how you\'re feeling right now.',
                style: TextStyle(fontSize: 18, color: Color(0xFF4A5772)),
              ),
              const SizedBox(height: 24),
              ...options.map((option) {
                final label = option.$1;
                final color = option.$2;
                final detail = option.$3;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CalmModeScreen(need: label, detail: detail),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: color.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E3354),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String _needLabel(String value) => value;
}

class CalmModeScreen extends StatelessWidget {
  const CalmModeScreen({super.key, required this.need, required this.detail});

  final String need;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final adjustments = <String>[
      'Lighting reduced',
      'Screen brightness reduced',
      'Brown noise playing',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Calm Mode Active'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.waves, size: 64, color: Color(0xFF7C8EF9)),
              const SizedBox(height: 16),
              const Text(
                'Calm Mode Active',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your environment has been adjusted to help you feel safer and calmer.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade700),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Active adjustments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3354),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...adjustments.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF4AA381),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              item,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF2D3B5C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current need',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3354),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      need,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E3354),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detail,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF495975),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SupportModeDetailsScreen(need: need),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8EF9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('View support details'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CaregiverSupportScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Caregiver Support'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('End Calm Mode'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CaregiverSupportScreen extends StatelessWidget {
  const CaregiverSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Step back and give space.',
      'Stay quiet. Do not ask questions.',
      'Offer a preferred support item without forcing it.',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Caregiver Support'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please follow these steps to support your loved one.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 18),
              ...steps.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final step = entry.value;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C8EF9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          step,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF2C3E5C),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8EF9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('I\'m Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupportPreferencesScreen extends StatefulWidget {
  const SupportPreferencesScreen({super.key});

  @override
  State<SupportPreferencesScreen> createState() =>
      _SupportPreferencesScreenState();
}

class _SupportPreferencesScreenState extends State<SupportPreferencesScreen> {
  final Map<String, bool> preferences = {
    'Loud sounds': true,
    'Bright lights': true,
    'Crowded spaces': true,
    'Strong smells': false,
    'Other': false,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('My Support Preferences'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Triggers'),
              Tab(text: 'Strategies'),
              Tab(text: 'Caregiver'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PreferenceList(
              items: const [
                'Loud sounds',
                'Bright lights',
                'Crowded spaces',
                'Strong smells',
                'Other',
              ],
              values: const {},
            ),
            _PreferenceList(
              items: const [
                'Quiet room',
                'Warm lighting',
                'Weighted blanket',
                'Cold water',
              ],
              values: const {},
            ),
            _PreferenceList(
              items: const [
                'Give me space',
                'Avoid questions',
                'Stay quiet',
                'Offer support without forcing',
              ],
              values: const {},
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceList extends StatefulWidget {
  const _PreferenceList({required this.items, required this.values});

  final List<String> items;
  final Map<String, bool> values;

  @override
  State<_PreferenceList> createState() => _PreferenceListState();
}

class _PreferenceListState extends State<_PreferenceList> {
  late final Map<String, bool> state = {
    for (final item in widget.items) item: widget.values[item] ?? false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: CheckboxListTile(
              value: state[item] ?? false,
              onChanged: (value) {
                setState(() {
                  state[item] = value ?? false;
                });
              },
              title: Text(item),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'date': '2 Apr 2025, 14:32',
        'trigger': 'Too noisy',
        'mode': 'Calm mode',
        'support': 'Light + Sound',
      },
      {
        'date': '29 Mar 2025, 18:10',
        'trigger': 'Too bright',
        'mode': 'Calm mode',
        'support': 'Dim light',
      },
      {
        'date': '23 Mar 2025, 09:47',
        'trigger': 'Too crowded',
        'mode': 'Quiet room',
        'support': 'Space + soft audio',
      },
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text('History'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Support Events'),
              Tab(text: 'Triggers'),
              Tab(text: 'Strategies'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: ListTile(
                      title: Text(
                        event['date']!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            event['trigger']!,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text('Support mode: ${event['mode']}'),
                          Text(
                            'Environmental adjustments: ${event['support']}',
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
            const Center(child: Text('Trigger summaries will appear here.')),
            const Center(child: Text('Helpful strategies will appear here.')),
          ],
        ),
      ),
    );
  }
}

class SupportModeDetailsScreen extends StatelessWidget {
  const SupportModeDetailsScreen({super.key, required this.need});

  final String need;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Support Mode Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calm Mode',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Based on your selection: "$need"',
                style: const TextStyle(fontSize: 18, color: Color(0xFF53667F)),
              ),
              const SizedBox(height: 24),
              _DetailSection(
                title: 'Lighting',
                values: const ['Warm', 'Dimmed'],
              ),
              const SizedBox(height: 16),
              _DetailSection(
                title: 'Screen',
                values: const ['Lower brightness'],
              ),
              const SizedBox(height: 16),
              _DetailSection(
                title: 'Sound',
                values: const ['Brown noise', 'Low volume'],
              ),
              const SizedBox(height: 24),
              const Text(
                'Preferred support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Quiet space',
                style: TextStyle(fontSize: 18, color: Color(0xFF495975)),
              ),
              const Text(
                'Weighted blanket',
                style: TextStyle(fontSize: 18, color: Color(0xFF495975)),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C8EF9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('End Calm Mode'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.values});

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E3354),
            ),
          ),
          const SizedBox(height: 8),
          ...values.map(
            (value) => Text(
              '• $value',
              style: const TextStyle(fontSize: 17, color: Color(0xFF465874)),
            ),
          ),
        ],
      ),
    );
  }
}

class SmartHomeScreen extends StatefulWidget {
  const SmartHomeScreen({super.key});

  @override
  State<SmartHomeScreen> createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  bool smartLightsEnabled = true;
  bool smartSpeakerEnabled = false;
  bool smartDisplayEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Smart Home Integration'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Optional',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7C8EF9),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connected smart devices can provide environmental control when needed.',
                style: TextStyle(fontSize: 18, color: Color(0xFF4E5974)),
              ),
              const SizedBox(height: 22),
              _SmartDeviceCard(
                name: 'Smart Lights',
                status: smartLightsEnabled ? 'Connected' : 'Disconnected',
                enabled: smartLightsEnabled,
                onChanged: (value) =>
                    setState(() => smartLightsEnabled = value),
              ),
              const SizedBox(height: 12),
              _SmartDeviceCard(
                name: 'Smart Speaker',
                status: smartSpeakerEnabled ? 'Connected' : 'Disconnected',
                enabled: smartSpeakerEnabled,
                onChanged: (value) =>
                    setState(() => smartSpeakerEnabled = value),
              ),
              const SizedBox(height: 12),
              _SmartDeviceCard(
                name: 'Smart Display',
                status: smartDisplayEnabled ? 'Connected' : 'Disconnected',
                enabled: smartDisplayEnabled,
                onChanged: (value) =>
                    setState(() => smartDisplayEnabled = value),
              ),
              const SizedBox(height: 20),
              const Text(
                'SOSs can still function without smart-home hardware.',
                style: TextStyle(fontSize: 16, color: Color(0xFF5D6982)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmartDeviceCard extends StatelessWidget {
  const _SmartDeviceCard({
    required this.name,
    required this.status,
    required this.enabled,
    required this.onChanged,
  });

  final String name;
  final String status;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: enabled
                ? const Color(0xFFDDE7FF)
                : const Color(0xFFE9ECF6),
            child: Icon(
              name.contains('Light')
                  ? Icons.light_mode
                  : name.contains('Speaker')
                  ? Icons.speaker
                  : Icons.monitor,
              color: enabled
                  ? const Color(0xFF4054B2)
                  : const Color(0xFF7382A3),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3354),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color: enabled
                        ? const Color(0xFF3B9D6C)
                        : const Color(0xFF7685A4),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}

class AISummaryScreen extends StatelessWidget {
  const AISummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('AI Support Summary'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF7C8EF9), size: 28),
                  SizedBox(width: 10),
                  Text(
                    'AI Support Summary',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E3354),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'This page summarises recent user-entered information and support choices.',
                style: TextStyle(fontSize: 18, color: Color(0xFF55657E)),
              ),
              const SizedBox(height: 26),
              const Text(
                'Recent Patterns',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 10),
              _InfoCard(
                text: 'User often reports loud sounds as a trigger.\nWarm lighting and quiet spaces appear helpful.',
              ),
              const SizedBox(height: 18),
              const Text(
                'Suggested Focus',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 10),
              _InfoCard(
                text: 'Try the weighted blanket when appropriate.\nConsider reducing screen brightness earlier in the day.',
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F6F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Important: This summary is based on user-entered information only. It does not diagnose, predict, or treat conditions.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5D6982)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF2D3B5C),
          height: 1.5,
        ),
      ),
    );
  }
}

class LargeSOSScreen extends StatelessWidget {
  const LargeSOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 28),
              const Text(
                'SOSs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'You\'re not alone.',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Let\'s get you to a calmer place.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Color(0xFF56657B)),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SelectNeedScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFC6B6B), Color(0xFFD7224B)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFC6B6B)
                                .withValues(alpha: 0.4),
                            blurRadius: 30,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 42),
                          SizedBox(height: 12),
                          Text(
                            'SOS / Calm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Sometimes it\'s okay to pause.',
                style: TextStyle(fontSize: 18, color: Color(0xFF4F6785)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SOSButton extends StatelessWidget {
  const _SOSButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label, Tap for support',
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          height: 158,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFA1304B), Color(0xFF812A42)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA1304B).withValues(alpha: 0.2),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite_outline_rounded,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tap for support',
                style: TextStyle(fontSize: 13, color: Color(0xFFEFCFD8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.label,
    required this.detail,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String detail;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label, $detail',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Container(
          height: 104,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: const Color(0xFFF0D8DF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFFA1304B), size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4A2631),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: const TextStyle(fontSize: 12, color: Color(0xFF765D64)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeBottomNav extends StatelessWidget {
  const _HomeBottomNav({required this.onSupport, required this.onHistory});

  final VoidCallback onSupport;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0D8DF))),
      ),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Row(
        children: [
          const Expanded(
            child: _BottomNavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              selected: true,
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.favorite_outline_rounded,
              label: 'My Support',
              onTap: onSupport,
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.schedule_rounded,
              label: 'History',
              onTap: onHistory,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: selected
                    ? const Color(0xFFA1304B)
                    : const Color(0xFF9A858B),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFFA1304B)
                      : const Color(0xFF765D64),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalmLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = const Color(0xFFFFE3B7);
    final backHillPaint = Paint()..color = const Color(0xFFF8E1D5);
    final frontHillPaint = Paint()..color = const Color(0xFFD7E7D0);
    final leafPaint = Paint()..color = const Color(0xFFA8C7AA);

    canvas.drawCircle(Offset(size.width - 52, 42), 30, sunPaint);
    final backHill = Path()
      ..moveTo(0, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.36,
        size.width * 0.62,
        size.height * 0.68,
      )
      ..quadraticBezierTo(
        size.width * 0.84,
        size.height * 0.86,
        size.width,
        size.height * 0.55,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backHill, backHillPaint);

    final frontHill = Path()
      ..moveTo(0, size.height * 0.84)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * 0.62,
        size.width * 0.68,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.94,
        size.width,
        size.height * 0.76,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontHill, frontHillPaint);

    final stem = Paint()
      ..color = const Color(0xFF7EA986)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width - 35, size.height * 0.84),
      Offset(size.width - 35, size.height * 0.44),
      stem,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width - 53, size.height * 0.56),
        width: 34,
        height: 15,
      ),
      leafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width - 18, size.height * 0.67),
        width: 34,
        height: 15,
      ),
      leafPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
