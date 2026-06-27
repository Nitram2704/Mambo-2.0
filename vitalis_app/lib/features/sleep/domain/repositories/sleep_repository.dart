import '../entities/sleep_record.dart';

abstract class SleepRepository {
  List<SleepRecord> getSleepRecords();
}
