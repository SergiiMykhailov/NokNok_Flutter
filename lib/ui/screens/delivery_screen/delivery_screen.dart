import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

import 'bloc/delivery_bloc.dart';
import 'bloc/delivery_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatefulWidget {

  // Public methods and properties

  DeliveryScreen(StoreRepository storeRepository,
    DeliveryScreenRouter router,
    {Key key})
    : _storeRepository = storeRepository,
      _router = router,
      super(key: key);

  // Overridden methods

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState(_storeRepository, _router);

  // Internal fields

  final StoreRepository _storeRepository;
  final DeliveryScreenRouter _router;

}

class _DeliveryScreenState extends State<DeliveryScreen>
  with BuildContextProvider {

  // Public methods and properties

  _DeliveryScreenState(StoreRepository storeRepository,
    DeliveryScreenRouter router,
    {Key key})
    : _deliveryBloc = DeliveryBloc(storeRepository, router),
      super() {
    _deliveryBloc.buildContextProvider = this;
  }

  // Overridden methods

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: BlocListener (
          bloc: _deliveryBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _deliveryBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, DeliveryState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, DeliveryState state) {
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _deliveryBloc.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, DeliveryState state) {
    if (state is DeliveryStateLoaded) {
      return _buildDeliveryScreen(context);
    }
    else {
      return buildLoadingWidget(context, "Loading delivery parameters...");
    }
  }

  Widget _buildDeliveryScreen(BuildContext context) {
    return buildScreenWidget(
      buildContext: context,
      headerHeight: DefaultHeaderHeight,
      footerHeight: DefaultFooterHeight,
      buildHeaderCallback: (BuildContext context) {
        return _buildHeader(context: context);
      },
      buildBodyCallback: (BuildContext context) {
        return _buildBody(context: context);
      },
      buildFooterCallback: (BuildContext context) {
        return _buildFooter(context: context);
      });
  }

  Widget _buildHeader({@required BuildContext context}) {
    return Container();
  }

  Widget _buildBody({@required BuildContext context}) {
    return Container();
  }

  Widget _buildFooter({@required BuildContext context}) {
    return Container();
  }

  // Internal fields

  final DeliveryBloc _deliveryBloc;

}
