import '../entities/user.dart';
import '../entities/activity.dart';

abstract class HomeRepository {
  User getUser();
  List<Activity> getRecentActivities();
}
