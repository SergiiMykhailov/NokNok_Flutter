import 'package:bloc/bloc.dart';
import 'package:nok_nok/blocs/store_block/store_event.dart';
import 'package:nok_nok/blocs/store_block/store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {

  @override
  StoreState get initialState => StoreStateLoading();

  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
  }
}