import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/stores_list_screen/routing/stores_list_screen_router.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

import 'bloc/stores_list_state.dart';
import 'bloc/stores_list_bloc.dart';

import 'package:nok_nok/data_access/repositories/base/root_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoresListScreen extends StatefulWidget {

  // Public methods and properties

  StoresListScreen(RootRepository rootRepository,
                   StoresListScreenRouter router,
                   {Key key})
    : _rootRepository = rootRepository,
      _router = router,
      super(key: key);

  @override
  _StoresListScreenState createState() => _StoresListScreenState(_rootRepository, _router);

  // Internal fields

  final RootRepository _rootRepository;
  final StoresListScreenRouter _router;

}

class _StoresListScreenState extends State<StoresListScreen>
                             with BuildContextProvider {

  // Public methods and properties

  _StoresListScreenState(RootRepository rootRepository,
                         StoresListScreenRouter router)
    : _storesListBloc = StoresListBloc(rootRepository, router),
      super() {
    _storesListBloc.buildContextProvider = this;
  }

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

  @override
  BuildContext getContext() {
    return context;
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, StoresListState state) {
    if (state is StoresListStateLoading) {
      return buildLoadingWidget(context, "Loading stores...");
    }
    else {
      return buildInvalidStateWidget();
    }
  }

  // Internal fields

  StoresListBloc _storesListBloc;

}