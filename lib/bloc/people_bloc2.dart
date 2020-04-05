import 'package:flutter_bloc/flutter_bloc.dart';

enum PeopleEvent2 {to_no_data, to_available_data}

class PeopleBloc2 extends Bloc<PeopleEvent2, String> {

  String _peopleData = 'Initial people data';

  @override
  String get initialState => 'Initial data';

  @override
  Stream<String> mapEventToState(PeopleEvent2 event) async* {
    if(event == PeopleEvent2.to_no_data) {
      _peopleData = 'Data not available';
    } else if(event == PeopleEvent2.to_available_data) {
      _peopleData = 'Data available';
    }
    yield _peopleData;
  }
}