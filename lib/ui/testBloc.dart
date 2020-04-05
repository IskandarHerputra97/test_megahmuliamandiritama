import 'package:flutter/material.dart';
import 'package:test_megahmuliamandiritama/bloc/people_bloc.dart';

class TestBloc extends StatefulWidget {
  @override
  _TestBlocState createState() => _TestBlocState();
}

class _TestBlocState extends State<TestBloc> {

  PeopleBloc peopleBloc = PeopleBloc();

  @override
  void dispose() {
    peopleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Bloc Pattern'),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: peopleBloc.stateStream,
            initialData: 'Initial data',
            builder: (context, snapshot) {
              return Text(
                snapshot.data,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  peopleBloc.eventSink.add(PeopleEvent.to_gotData);
                },
                child: Text(
                  'Ada data',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  peopleBloc.eventSink.add(PeopleEvent.to_noData);
                },
                child: Text(
                  'Tidak ada data',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
