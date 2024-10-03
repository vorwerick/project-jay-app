import 'package:app/application/bloc/alarms/alarm_control_bloc.dart';
import 'package:app/presentation/components/fab/jay_fab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JayFab extends StatefulWidget {

  final int eventId;
  final int memberId;
   JayFab({super.key, required this.eventId, required this.memberId});

  @override
  State<JayFab> createState() => _JayFabState();
}

class _JayFabState extends State<JayFab> {
  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => AlarmControlBloc()..add(AlarmControlGetStateStarted(eventId: widget.eventId,memberId: widget.memberId)),
        child:  JayFabView(eventId: widget.eventId, memberId: widget.memberId,),
      );
}
