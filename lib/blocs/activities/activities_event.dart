part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  bool get stringify => true;
}

class LoadActivitesEvent extends ActivitiesEvent {
  @override
  List<Object> get props => [];
}

class AddEditActivityEvent extends ActivitiesEvent {
  final Activity activity;

  AddEditActivityEvent(this.activity);

  @override
  List<Object> get props => [activity];
}