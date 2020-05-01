import 'package:teamgo/data_providers/activities.dart';
import 'package:teamgo/models/activity.dart';
import 'package:teamgo/repos/activities.dart';

class MockActivitiesRepository implements ActivitiesRepository {
  final ActivitiesDataProvider activitiesDataProvider;

  MockActivitiesRepository(this.activitiesDataProvider);

  @override
  Future<List<Activity>> getActivities() async {
    final rawItems = await activitiesDataProvider.getActivites();
    final acitivities = rawItems.map((rawItem) => Activity.fromRaw(rawItem)).toList();
    return acitivities;
  }
}
