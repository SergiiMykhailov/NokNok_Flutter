import 'package:nok_nok/blocs/store_block/store_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nok_nok/blocs/store_block/store_state.dart';

class StoreScreen extends StatefulWidget {

  StoreScreen({Key key})
   : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();

}

class _StoreScreenState extends State<StoreScreen> {

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
      return _buildLoadingScreen();
    }
    else if (state is StoreStateLoaded) {
      return _buildStoreScreen();
    }
    else {
      return Center(
        child: Text("Invalid screen state"),
      );
    }
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
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
          child:
          Container(
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

  final _storeBloc = StoreBloc();

}
