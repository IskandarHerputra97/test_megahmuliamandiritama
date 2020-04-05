import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_megahmuliamandiritama/bloc/people_bloc.dart';
import 'package:test_megahmuliamandiritama/bloc/people_bloc2.dart';

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

    PeopleBloc2 peopleBloc2 = BlocProvider.of<PeopleBloc2>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Bloc Pattern'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Text(
              'Bloc standar',
            ),
          ),
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
          SizedBox(height: 20.0),
          Container(
            color: Colors.red,
            child: Text(
              'Bloc with flutter_bloc package',
            ),
          ),
          BlocBuilder<PeopleBloc2, String>(
            builder: (context, currentString) => Text(
              currentString,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  peopleBloc2.add(PeopleEvent2.to_available_data);
                },
                child: Text(
                  'Ada data',
                ),
              ),
              RaisedButton(
                onPressed: () {
                  peopleBloc2.add(PeopleEvent2.to_no_data);
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
