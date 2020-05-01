import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamgo/blocs/activities/activities_bloc.dart';
import 'package:teamgo/widgets/activity_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder(
          bloc: BlocProvider.of<ActivitiesBloc>(context),
          builder: (context, state) => _buildState(context, state),
        ),
      ),
    );
  }

  _buildState(BuildContext context, ActivitiesState state) {
    if (state is IdleActivitiesState) {
      final activities = state.activities;

      return ListView.separated(
        padding: EdgeInsets.only(bottom: 64),
        itemBuilder: (context, position) => ActivityCard(
          activity: activities[position],
        ),
        separatorBuilder: (context, position) => SizedBox(
          height: 16,
        ),
        itemCount: activities.length,
      );
    }

    return Container();
  }
}
