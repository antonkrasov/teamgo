part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  bool get stringify => true;
}

class LoadingActivitiesState extends ActivitiesState {
  @override
  List<Object> get props => [];
}

class ErrorActivitiesState extends ActivitiesState {
  final Exception error;

  ErrorActivitiesState(this.error);

  @override
  List<Object> get props => [error];
}

class IdleActivitiesState extends ActivitiesState {
  final List<Activity> activities;

  IdleActivitiesState(this.activities);

  @override
  List<Object> get props => [activities];
}
