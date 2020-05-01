import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamgo/blocs/activities/activities_bloc.dart';
import 'package:teamgo/styles/colors.dart';
import 'package:teamgo/styles/text.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildSplashTitle(),
            _buildBloc(context),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ActivitiesBloc, dynamic> _buildBloc(BuildContext context) {
    return BlocConsumer(
      bloc: BlocProvider.of<ActivitiesBloc>(context),
      listener: (context, state) {
        if (state is IdleActivitiesState) {
          Navigator.of(context).pushReplacementNamed('home');
        }
      },
      builder: (context, state) => _buildState(context, state),
    );
  }

  Text _buildSplashTitle() {
    return Text(
      'Go',
      style: TeamGoTextStyles.splash,
    );
  }

  _buildState(BuildContext context, ActivitiesState state) {
    if (state is LoadingActivitiesState) {
      return _buildLoadingState(context);
    }

    if (state is ErrorActivitiesState) {
      return _buildErrorState(context, state.error);
    }

    return Container();
  }

  _buildLoadingState(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 32,
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(TeamGoColors.primaryColor),
          strokeWidth: 1,
        ),
      ),
    );
  }

  _buildErrorState(BuildContext context, Exception error) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_buildErrorText(error)),
          SizedBox(
            height: 12,
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<ActivitiesBloc>(context).add(
                LoadActivitesEvent(),
              );
            },
            color: TeamGoColors.primaryColor,
            child: Text(
              'Retry',
              style: TeamGoTextStyles.button,
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  _buildErrorText(Exception error) {
    return 'Error: $error';
  }
}
