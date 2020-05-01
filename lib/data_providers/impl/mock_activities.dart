import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:teamgo/data_providers/activities.dart';

class MockActivitiesDataProvider implements ActivitiesDataProvider {
  @override
  Future<List<Map>> getActivites() async {
    final rawJsonString = await rootBundle.loadString('assets/mock_data.json');
    final rawJson = json.decode(rawJsonString);
    final rawItems = (rawJson as List).map((rawItem) => rawItem as Map).toList();
    return rawItems;
  }
}
