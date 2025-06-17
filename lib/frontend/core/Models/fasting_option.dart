class FastingOption {
  final String name;
  final int fastingHours;
  final int eatingHours;
  final bool isTestMode;

  const FastingOption({
    required this.name,
    required this.fastingHours,
    required this.eatingHours,
    this.isTestMode = false,
  });

  static const List<FastingOption> options = [
    FastingOption(
      name: '2min:1min (Test)',
      fastingHours: 0,
      eatingHours: 0,
      isTestMode: true,
    ),
    FastingOption(name: '12:12', fastingHours: 12, eatingHours: 12),
    FastingOption(name: '14:10', fastingHours: 14, eatingHours: 10),
    FastingOption(name: '16:8', fastingHours: 16, eatingHours: 8),
    FastingOption(name: '18:6', fastingHours: 18, eatingHours: 6),
    FastingOption(name: '20:4', fastingHours: 20, eatingHours: 4),
  ];

  Duration get fastingDuration => isTestMode 
    ? const Duration(minutes: 2) 
    : Duration(hours: fastingHours);
    
  Duration get eatingDuration => isTestMode 
    ? const Duration(minutes: 1) 
    : Duration(hours: eatingHours);
} 