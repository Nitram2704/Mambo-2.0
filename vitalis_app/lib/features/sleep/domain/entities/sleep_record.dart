class SleepRecord {
  final String day;
  final String hours;
  final double progress;
  final String range;
  final String? pill;
  final String? pillLabel;

  const SleepRecord({
    required this.day,
    required this.hours,
    required this.progress,
    required this.range,
    this.pill,
    this.pillLabel,
  });
}
