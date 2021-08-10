import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitial());

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
