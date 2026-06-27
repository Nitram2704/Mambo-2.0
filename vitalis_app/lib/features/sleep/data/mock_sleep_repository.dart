import 'package:vitalis_app/features/sleep/domain/entities/sleep_record.dart';
import 'package:vitalis_app/features/sleep/domain/repositories/sleep_repository.dart';

class MockSleepRepository implements SleepRepository {
  @override
  List<SleepRecord> getSleepRecords() {
    return const [
      SleepRecord(
        day: 'Hoy',
        hours: '7:12',
        progress: 0.9,
        range: '23:15 – 06:27',
      ),
      SleepRecord(
        day: 'Ayer',
        hours: '6:45',
        progress: 0.84,
        range: '00:30 – 07:15',
        pill: 'warning',
        pillLabel: 'Poco',
      ),
      SleepRecord(
        day: 'Lun',
        hours: '8:00',
        progress: 1.0,
        range: '22:30 – 06:30',
        pill: 'success',
        pillLabel: 'Bien',
      ),
      SleepRecord(
        day: 'Dom',
        hours: '5:30',
        progress: 0.69,
        range: '02:00 – 07:30',
        pill: 'error',
        pillLabel: 'Muy poco',
      ),
    ];
  }
}
