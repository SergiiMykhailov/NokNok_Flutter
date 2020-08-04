import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/total_cost_widget.dart';

import 'bloc/delivery_time_bloc.dart';
import 'bloc/delivery_time_state.dart';

class DeliveryTimeScreen extends StatefulWidget {

  // Public methods and properties

  DeliveryTimeScreen(
    StoreRepository storeRepository,
    String address,
    DeliveryTimeScreenRouter router,
    {Key key})
    : _storeRepository = storeRepository,
      _address = address,
      _router = router,
      super(key: key);

  // Overridden methods

  @override
  _DeliveryTimeScreenState createState() => _DeliveryTimeScreenState(_storeRepository, _address, _router);

  // Internal fields

  final StoreRepository _storeRepository;
  final DeliveryTimeScreenRouter _router;
  final String _address;

}

class _DeliveryTimeScreenState extends State<DeliveryTimeScreen>
  with BuildContextProvider {

  // Public methods and properties

  _DeliveryTimeScreenState(
    StoreRepository storeRepository,
    String address,
    DeliveryTimeScreenRouter router,
    {Key key})
    : _deliveryTimeBloc = DeliveryTimeBloc(storeRepository, address, router),
      super() {
    _deliveryTimeBloc.buildContextProvider = this;
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
          bloc: _deliveryTimeBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _deliveryTimeBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, DeliveryTimeState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, DeliveryTimeState state) {
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _deliveryTimeBloc.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, DeliveryTimeState state) {
    if (state is DeliveryTimeStateLoaded) {
      return _buildDeliveryTimeScreen(context, state);
    }
    else {
      return buildLoadingWidget(context, "Loading available delivery slots...");
    }
  }

  Widget _buildDeliveryTimeScreen(BuildContext context, DeliveryTimeState state) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: buildScreenWidget(
        buildContext: context,
        headerHeight: _HeaderHeight,
        footerHeight: _FooterHeight,
        buildHeaderCallback: (BuildContext context) {
          return _buildHeader(context: context);
        },
        buildBodyCallback: (BuildContext context) {
          final loadedState = state as DeliveryTimeStateLoaded;
          return _buildBody(context: context, state: loadedState);
        },
        buildFooterCallback: (BuildContext context) {
          final loadedState = state as DeliveryTimeStateLoaded;
          return _buildFooter(context: context, state: loadedState);
        })
    );
  }

  Widget _buildHeader({@required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CupertinoButton(
          child: Container(
            width: 15,
            height: 44,
            child: ImageIcon(NokNokImages.back,
              color: NokNokColors.mainThemeColor)),
          onPressed: () {
            _deliveryTimeBloc.navigateBack();
          },
        ),
        Expanded(
          child: Center(
            child: Container(
              child: Text(
                'Delivery time',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.caption,
                  fontWeight: FontWeight.bold,
                  color: NokNokColors.mainThemeColor),
              ),
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }

  Widget _buildBody({@required BuildContext context,
    @required DeliveryTimeStateLoaded state}) {
    return Container();
  }

  Widget _buildFooter({@required BuildContext context,
    @required DeliveryTimeStateLoaded state}) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: Container(),),
            Container(
              height: 51,
              child: TotalCostWidget(
                state.basket.totalCost,
                onPurchaseClicked: () {
                  _deliveryTimeBloc.purchase();
                },
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
        SizedBox(height: 25)
      ],
    );
  }

  // Internal fields

  final DeliveryTimeBloc _deliveryTimeBloc;

  static const _HeaderHeight = 90.0;
  static const _FooterHeight = 135.0;

}
