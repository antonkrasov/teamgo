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

class AddActivityEvent extends ActivitiesEvent {
  final Activity activity;

  AddActivityEvent(this.activity);

  @override
  List<Object> get props => [activity];
}

class EditActivityEvent extends ActivitiesEvent {
  final Activity activity;

  EditActivityEvent(this.activity);

  @override
  List<Object> get props => [activity];
}
