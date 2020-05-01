import 'package:teamgo/models/activity.dart';

abstract class ActivitiesRepository {
  Future<List<Activity>> getActivities();
}
