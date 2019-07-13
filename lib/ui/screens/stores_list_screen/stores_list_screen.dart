import 'package:nok_nok/ui/routing/base_router.dart';

import 'bloc/stores_list_state.dart';
import 'bloc/stores_list_bloc.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';
import 'package:nok_nok/ui/utils/utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresListScreen extends StatefulWidget {

  // Public methods and properties

  StoresListScreen(RootRepository rootRepository, {Key key})
    : _rootRepository = rootRepository, super(key: key);

  @override
  _StoresListScreenState createState() => _StoresListScreenState(_rootRepository);

  // Internal fields

  final RootRepository _rootRepository;

}

class _StoresListScreenState extends State<StoresListScreen> {

  // Public methods and properties

  _StoresListScreenState(RootRepository rootRepository)
    : _storesListBloc = StoresListBloc(rootRepository), super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: BlocListener (
          bloc: _storesListBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _storesListBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, StoresListState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, StoresListState state) {
            _handleState(context, state);
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _storesListBloc.dispose();

    super.dispose();
  }

  // Internal methods

  void _handleState(BuildContext context, StoresListState state) {
    if (state is StoresListStateNavigatingToStore) {
      Navigator.pushNamed(
        context,
        BaseRouter.Store,
        arguments: state.storeRepository);
    }
  }

  Widget _buildScreen(BuildContext context, StoresListState state) {
    if (state is StoresListStateLoading) {
      return buildLoadingWidget(context, "Loading stores...");
    }
    else if (state is StoresListStateNavigatingToStore) {
      return _buildStoresListScreen();
    }
    else {
      return buildInvalidStateWidget();
    }
  }

  Widget _buildStoresListScreen() {
    return Container(
      color: CupertinoColors.white,
    );
  }

  // Internal fields

  StoresListBloc _storesListBloc;

}