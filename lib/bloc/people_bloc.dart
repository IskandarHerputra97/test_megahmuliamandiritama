import 'dart:async';

import 'package:flutter/material.dart';

enum PeopleEvent {to_noData, to_gotData}

class PeopleBloc {
  String _peopleData = 'default data people';

  StreamController<PeopleEvent> _eventController = StreamController<PeopleEvent>();
  StreamSink<PeopleEvent> get eventSink => _eventController.sink;

  StreamController<String> _stateController = StreamController<String>();
  StreamSink<String> get _stateSink => _stateController.sink;
  Stream<String> get stateStream => _stateController.stream;

  void _mapEventToState(PeopleEvent peopleEvent)
  {
    if(peopleEvent == PeopleEvent.to_noData) {
      _peopleData = 'Tidak ada data!';
    } else {
      _peopleData = 'Ada data';
    }

    _stateSink.add(_peopleData);
  }

  PeopleBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}