import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              const _MiniTaskWidget(),
              const SizedBox(height: 14),
              
              // Mood Journal Button
              InkWell(
                borderRadius: BorderRadius.circular(19),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MoodJournalScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8EEFF), Color(0xFFF4F0FF)],
                    ),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: const Color(0xFFD4E0FF)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit_note_rounded, color: Color(0xFF5669D9), size: 28),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mood Journal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E3354),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Write down your thoughts and feelings',
                              style: TextStyle(fontSize: 12, color: Color(0xFF4A5772)),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF5669D9)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Hong Kong Scenery Button
              InkWell(
                borderRadius: BorderRadius.circular(19),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScenerySpotsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE5EC), Color(0xFFFFF0F3)],
                    ),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: const Color(0xFFF2C2D0)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.wb_sunny_rounded, color: Color(0xFFA1304B), size: 28),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HK Scenic & Sunset Spots',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A2631),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Find a peaceful seaside to unwind',
                              style: TextStyle(fontSize: 12, color: Color(0xFF765D64)),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFA1304B)),
                    ],
                  ),
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

class HistoryStore {
  static List<Map<String, String>> pastEvents = [];

  // Load past events from SharedPreferences when app starts
  static Future<void> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventsString = prefs.getString('saved_history_events');
    if (eventsString != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(eventsString);
        pastEvents = decodedList.map((item) => Map<String, String>.from(item)).toList();
      } catch (e) {
        // Ignore parse error
      }
    }
  }

  // Save past events to SharedPreferences whenever a new record is added
  static Future<void> addRecord({required String title, required String detail, required String time}) async {
    pastEvents.insert(0, {
      'title': title,
      'detail': detail,
      'time': time,
    });

    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(pastEvents);
    await prefs.setString('saved_history_events', encodedList);
  }
}

// ==========================================
// MOOD JOURNAL SCREEN (Fixed)
// ==========================================
class JournalDataStore {
  static List<Map<String, String>> sharedEntries = [];
}

class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  State<MoodJournalScreen> createState() => _MoodJournalScreenState();
}

class _MoodJournalScreenState extends State<MoodJournalScreen> {
  final TextEditingController _journalController = TextEditingController();
  String _selectedMood = '😊 Calm';
  List<Map<String, String>> _savedEntries = [];

  final List<String> _moods = ['😊 Calm', '😌 Relaxed', '🌧️ Overwhelmed', '⚡ Anxious', '💪 Strong'];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? entriesString = prefs.getString('saved_mood_entries');
    if (entriesString != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(entriesString);
        setState(() {
          _savedEntries = decodedList.map((item) => Map<String, String>.from(item)).toList();
        });
      } catch (e) {
        // Ignore parse error
      }
    }
  }

  Future<void> _saveEntriesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(_savedEntries);
    await prefs.setString('saved_mood_entries', encodedList);
  }

  void _saveEntry() {
    final journalText = _journalController.text.trim();
    if (journalText.isEmpty) return;
    final timeStr = DateTime.now().toString().substring(0, 16);

    setState(() {
      _savedEntries.insert(0, {
        'mood': _selectedMood,
        'text': journalText,
        'time': timeStr,
      });
      _journalController.clear();
    });

    _saveEntriesToPrefs();

    HistoryStore.addRecord(
      title: 'Mood Journal: $_selectedMood',
      detail: journalText,
      time: timeStr,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journal entry saved successfully!')),
    );
  }

  // Function to delete an entry by index
  void _deleteEntry(int index) {
    setState(() {
      _savedEntries.removeAt(index);
    });
    _saveEntriesToPrefs();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journal entry deleted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Mood Journal'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How are you feeling right now?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1E3354)),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _moods.map((mood) {
                    final isSelected = _selectedMood == mood;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(mood),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedMood = mood;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _journalController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write down your thoughts here...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFD4E2FF)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5669D9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text('Save Entry'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Recent Entries',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1E3354)),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _savedEntries.isEmpty
                    ? const Center(
                        child: Text(
                          'No entries yet. Write your first thought above!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _savedEntries.length,
                        itemBuilder: (context, index) {
                          final entry = _savedEntries[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry['mood']!,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            entry['time']!,
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                          const SizedBox(width: 8),
                                          // Delete icon button added here
                                          InkWell(
                                            onTap: () => _deleteEntry(index),
                                            child: const Icon(
                                              Icons.delete_outline_rounded,
                                              size: 18,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(entry['text']!),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ==========================================
// SCENERY SPOTS SCREEN
// ==========================================
class SunsetSpot {
  final String title;
  final String location;
  final String description;
  final String bestTime;
  final IconData icon;

  const SunsetSpot({
    required this.title,
    required this.location,
    required this.description,
    required this.bestTime,
    required this.icon,
  });
}

class ScenerySpotsScreen extends StatelessWidget {
  const ScenerySpotsScreen({super.key});

  static const List<SunsetSpot> _spots = [
    SunsetSpot(
      title: 'Belcher Bay Promenade',
      location: 'Kennedy Town',
      description: 'Convenient location with open views of Victoria Harbour, grassy areas, and wooden boardwalks, perfect for relaxing.',
      bestTime: 'Sunset hours',
      icon: Icons.water_rounded,
    ),
    SunsetSpot(
      title: 'Ha Pak Nai',
      location: 'Lau Fau Shan, Yuen Long',
      description: 'Famous sunset spot known as the "Mirror of the Sky" with stunning tidal flats and reflections.',
      bestTime: 'before sunset',
      icon: Icons.wb_sunny_rounded,
    ),
    SunsetSpot(
      title: 'Central Harbourfront',
      location: 'Central',
      description: 'An oasis in the bustling city overlooking both sides of Victoria Harbour with tranquil evening views.',
      bestTime: 'Dusk to Evening',
      icon: Icons.location_city_rounded,
    ),
    SunsetSpot(
      title: 'Stanley Murray House & Pier',
      location: 'Stanley',
      description: 'European-style seaside offering gorgeous sea views of Stanley Bay away from city noise.',
      bestTime: 'Afternoon to Sunset',
      icon: Icons.tsunami_rounded,
    ),
    SunsetSpot(
      title: 'Butterfly Beach Park',
      location: 'Tuen Mun',
      description: 'Features a long promenade and beach where you can watch the sun slowly dip below the horizon.',
      bestTime: 'Sunset',
      icon: Icons.beach_access_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('HK Scenic & Sunset Spots'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _spots.length,
          itemBuilder: (context, index) {
            final spot = _spots[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFF0D8DF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6DCE4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(spot.icon, color: const Color(0xFFA1304B), size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          spot.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4A2631),
                          ),
                        ),
                        const SizedBox(height: 6),
                        
                        // Uses Wrap to prevent horizontal overflow[cite: 1]
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.place, size: 14, color: Color(0xFFA1304B)),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    spot.location,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFA1304B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.access_time, size: 14, color: Color(0xFF765D64)),
                                const SizedBox(width: 4),
                                Text(
                                  spot.bestTime,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF765D64),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        Text(
                          spot.description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Color(0xFF534347),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// SELECT NEED SCREEN
// ==========================================
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

// ==========================================
// CALM MODE SCREEN
// ==========================================
class CalmModeScreen extends StatefulWidget {
  const CalmModeScreen({super.key, required this.need, required this.detail});

  final String need;
  final String detail;

  @override
  State<CalmModeScreen> createState() => _CalmModeScreenState();
}

class _CalmModeScreenState extends State<CalmModeScreen> {
  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;

  @override
  void initState() {
    super.initState();

    final timeStr = DateTime.now().toString().substring(0, 16);
    HistoryStore.addRecord(
      title: 'Calm Mode Active: ${widget.need}',
      detail: 'Triggered because ${widget.detail}. Applied lighting and brown noise adjustments.',
      time: timeStr,
    );

    _quoteTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentQuoteIndex = (_currentQuoteIndex + 1) % EncouragementNotificationManager.encouragementSentences.length;
      });
    });
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adjustments = <String>[
      'Lighting reduced',
      'Screen brightness reduced',
      'Brown noise playing',
    ];

    final currentQuote = EncouragementNotificationManager.encouragementSentences[_currentQuoteIndex];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Calm Mode Active'),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // <-- Wrapped in SingleChildScrollView to prevent vertical overflow
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
              
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  key: ValueKey<int>(_currentQuoteIndex),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD4E2FF)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Color(0xFF5669D9), size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          currentQuote,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2C3E5C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const _MiniTaskWidget(),
              const SizedBox(height: 20),
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
                            Expanded( // <-- Prevent text overflow inside adjustment row
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2D3B5C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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

// ==========================================
// MINI TASK WIDGET
// ==========================================
class CalmTask {
  final String title;
  final String description;
  final IconData icon;

  const CalmTask({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _MiniTaskWidget extends StatelessWidget {
  const _MiniTaskWidget();

  static const List<CalmTask> _tasks = [
    CalmTask(
      title: '5-4-3-2-1 Grounding',
      description: 'Look around and name: 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, and 1 you can taste.',
      icon: Icons.visibility_rounded,
    ),
    CalmTask(
      title: 'Box Breathing',
      description: 'Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, and hold empty for 4 seconds. Repeat 3 times.',
      icon: Icons.air_rounded,
    ),
    CalmTask(
      title: 'Cold Water Reset',
      description: 'Go splash cool water onto your wrists or face to quickly lower your heart rate and shift sensory focus.',
      icon: Icons.water_drop_rounded,
    ),
    CalmTask(
      title: 'Shoulder Drop & Release',
      description: 'Inhale deeply while lifting your shoulders up to your ears, then let them drop completely limp as you exhale.',
      icon: Icons.self_improvement_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8EEFF), Color(0xFFF4F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4E0FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF5669D9)),
              SizedBox(width: 8),
              Text(
                'Quick Calm Mini-Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3354),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Need an anchor? Randomly pick a quick focus exercise to ease your mind right now.',
            style: TextStyle(fontSize: 14, color: Color(0xFF4A5772)),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final randomTask = _tasks[Random().nextInt(_tasks.length)];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _RandomMiniTaskScreen(task: randomTask),
                  ),
                );
              },
              icon: const Icon(Icons.shuffle_rounded),
              label: const Text('Pick a Random Calm Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5669D9),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RandomMiniTaskScreen extends StatelessWidget {
  const _RandomMiniTaskScreen({required this.task});

  final CalmTask task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Random Calm Task'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF1FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(task.icon, size: 54, color: const Color(0xFF5669D9)),
              ),
              const SizedBox(height: 24),
              Text(
                task.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3354),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                task.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
                  color: Color(0xFF495975),
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5669D9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Done, I feel a bit better'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ENCOURAGEMENT MANAGER
// ==========================================
class EncouragementNotificationManager {
  static const List<String> encouragementSentences = [
    "You did a wonderful job navigating today. Take a gentle breath, you are safe.",
    "Proud of how hard you tried today. Remember to be kind to yourself.",
    "Even small steps count. You're doing better than you think!",
    "Pause for a second. Drop your shoulders, breathe out, and smile—you're doing great.",
    "No matter how heavy today felt, you handled it with incredible strength.",
  ];
}

// ==========================================
// OTHER SCREENS & HELPERS
// ==========================================
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

class SupportPreferencesScreen extends StatelessWidget {
  const SupportPreferencesScreen({super.key});

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
        body: const TabBarView(
          children: [
            _PreferenceList(
              items: [
                'Loud sounds',
                'Bright lights',
                'Crowded spaces',
                'Strong smells',
                'Other',
              ],
              values: {},
            ),
            _PreferenceList(
              items: [
                'Quiet room',
                'Warm lighting',
                'Weighted blanket',
                'Cold water',
              ],
              values: {},
            ),
            _PreferenceList(
              items: [
                'Give me space',
                'Avoid questions',
                'Stay quiet',
                'Offer support without forcing',
              ],
              values: {},
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

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, String>> _allEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    await HistoryStore.loadRecords();
    setState(() {
      _allEvents = HistoryStore.pastEvents;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Past Events & History'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _allEvents.isEmpty
                  ? const Center(
                      child: Text(
                        'No past events yet.\nYour Calm Mode activations and Mood Journal entries will appear here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _allEvents.length,
                      itemBuilder: (context, index) {
                        final event = _allEvents[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        event['title']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFFA1304B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      event['time']!,
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  event['detail']!,
                                  style: const TextStyle(fontSize: 14, color: Color(0xFF4A2631)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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