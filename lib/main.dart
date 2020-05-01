import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamgo/blocs/activities/activities_bloc.dart';
import 'package:teamgo/data_providers/impl/mock_activities.dart';
import 'package:teamgo/repos/impl/mock_activities.dart';
import 'package:teamgo/router.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activitiesDataProvider = MockActivitiesDataProvider();
    final activitiesRepository = MockActivitiesRepository(
      activitiesDataProvider,
    );
    //ignore: close_sinks
    final activitiesBloc = ActivitiesBloc(activitiesRepository)
      ..add(
        LoadActivitesEvent(),
      );

    return BlocProvider.value(
      value: activitiesBloc,
      child: MaterialApp(
        title: 'TeamGo',
        theme: ThemeData(
          fontFamily: 'WorkSans',
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Router.generateRoute,
        initialRoute: 'splash',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
