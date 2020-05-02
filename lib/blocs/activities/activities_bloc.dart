import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teamgo/models/activity.dart';
import 'package:teamgo/repos/activities.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final ActivitiesRepository repository;

  ActivitiesBloc(this.repository);

  @override
  ActivitiesState get initialState => LoadingActivitiesState();

  @override
  Stream<ActivitiesState> mapEventToState(
    ActivitiesEvent event,
  ) async* {
    if (event is LoadActivitesEvent) {
      yield* _handleLoadActivitesEvent();
    } else if (event is AddEditActivityEvent) {
      yield* _handleAddActivityEvent(event);
    }
  }

  Stream<ActivitiesState> _handleLoadActivitesEvent() async* {
    yield LoadingActivitiesState();

    try {
      final activites = await repository.getActivities();

      yield IdleActivitiesState(activites);
    } catch (ex) {
      yield ErrorActivitiesState(ex);
    }
  }

  Stream<ActivitiesState> _handleAddActivityEvent(
    AddEditActivityEvent event,
  ) async* {
    final currentState = state;
    if (currentState is IdleActivitiesState) {
      final activities = currentState.activities;
      activities.insert(0, event.activity);

      yield IdleActivitiesState(activities);
    }
  }
}
