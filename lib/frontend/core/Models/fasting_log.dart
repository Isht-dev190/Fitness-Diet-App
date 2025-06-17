class FastingLog {
  final DateTime startTime;
  final DateTime? endTime;
  final String fastingType;
  final Duration duration;

  const FastingLog({
    required this.startTime,
    this.endTime,
    required this.fastingType,
    required this.duration,
  });

  String get formattedStartTime => '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
  
  String get formattedEndTime => endTime != null 
    ? '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}'
    : '--:--';

  String get formattedDate => '${startTime.day}/${startTime.month}/${startTime.year}';

  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
} 