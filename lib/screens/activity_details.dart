import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamgo/blocs/activities/activities_bloc.dart';
import 'package:teamgo/models/activity.dart';
import 'package:teamgo/styles/colors.dart';
import 'package:teamgo/styles/text.dart';
import 'package:teamgo/widgets/activity_card.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final Activity paramActivity;

  const ActivityDetailsScreen({
    Key key,
    @required this.paramActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<ActivitiesBloc>(context),
        builder: (context, state) => _buildState(context, state),
      ),
    );
  }

  _buildState(BuildContext context, ActivitiesState state) {
    if (state is IdleActivitiesState) {
      // sure this should be done in a better way
      // (like separate BloC with requesting specific item from Repository)
      // but I think for demo it's fine...
      final renderActivity = state.activities.firstWhere(
        (Activity test) => test.id == paramActivity.id,
      );
      if (renderActivity != null) {
        return _renderActivityDetails(context, renderActivity);
      }
    }

    return Container();
  }

  _renderActivityDetails(context, Activity activity) {
    return Column(
      children: <Widget>[
        ActivityCard(
          activity: activity,
        ),
        if (activity.createdByUser) _buildEditButton(context, activity)
      ],
    );
  }

  _buildEditButton(context, activity) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          'add_edit_activity',
          arguments: activity,
        );
      },
      color: TeamGoColors.primaryColor,
      child: Text(
        'Edit',
        style: TeamGoTextStyles.button,
      ),
    );
  }
}
