import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'bloc/store_bloc.dart';
import 'bloc/store_state.dart';

import 'package:nok_nok/ui/utils/utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {

  // Public methods and properties

  StoreScreen(StoreRepository storeRepository, {Key key})
   : _storeRepository = storeRepository, super(key: key);

  // Overridden methods

  @override
  _StoreScreenState createState() => _StoreScreenState(storeRepository: _storeRepository);

  // Internal fields

  final StoreRepository _storeRepository;

}

class _StoreScreenState extends State<StoreScreen> {

  // Public methods and properties

  _StoreScreenState({Key key, StoreRepository storeRepository})
    : _storeBloc = StoreBloc(storeRepository), super();

  // Overridden methods

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: BlocListener (
          bloc: _storeBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _storeBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, StoreState state) {
              return _buildScreen(state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, StoreState state) {
            // Nothing to do at the moment.
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _storeBloc.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(StoreState state) {
    if (state is StoreStateLoading) {
      return buildLoadingWidget("Loading store items...");
    }
    else if (state is StoreStateLoaded) {
      return _buildStoreScreen();
    }
    else {
      return buildInvalidStateWidget();
    }
  }

  Widget _buildStoreScreen() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          child:
          SizedBox(
            width: 30,
            child: Text("Left column"),
          )
        ),
        VerticalDivider(
          indent: 0,
          color: CupertinoColors.activeBlue,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child:
            Center(
              child: Text("Right column"),
            ),
          ),
        )
      ],
    );
  }

  // Internal fields

  final _storeBloc;

}
