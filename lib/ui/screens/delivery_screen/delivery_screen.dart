import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_screen/routing/delivery_screen_router.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/total_cost_widget.dart';

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
      return _buildDeliveryScreen(context, state);
    }
    else {
      return buildLoadingWidget(context, "Loading delivery parameters...");
    }
  }

  Widget _buildDeliveryScreen(BuildContext context, DeliveryState state) {
    return buildScreenWidget(
      buildContext: context,
      headerHeight: _HeaderHeight,
      footerHeight: _FooterHeight,
      buildHeaderCallback: (BuildContext context) {
        return _buildHeader(context: context);
      },
      buildBodyCallback: (BuildContext context) {
        final loadedState = state as DeliveryStateLoaded;
        return _buildBody(context: context, state: loadedState);
      },
      buildFooterCallback: (BuildContext context) {
        final loadedState = state as DeliveryStateLoaded;
        return _buildFooter(context: context, state: loadedState);
      });
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
            _deliveryBloc.navigateBack();
          },
        ),
        Expanded(
          child: Center(
            child: Container(
              child: Text(
                'Delivery',
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
                     @required DeliveryStateLoaded state}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildContactInfo(context, state)
        ],
      ),
    );
  }

  Widget _buildFooter({@required BuildContext context,
                       @required DeliveryStateLoaded state}) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 14,),
            Text(
              'Delivery:',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: NokNokFonts.caption,
                color: NokNokColors.mainThemeColor),
            ),
            Expanded(child: Container()),
            Text(
              'Free',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: NokNokFonts.caption,
                color: NokNokColors.mainThemeColor),
            ),
            SizedBox(width: 17,)
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Expanded(child: Container(),),
            Container(
              height: 51,
              child: TotalCostWidget(
                state.basket.totalCost,
                onPurchaseClicked: () {
                  _deliveryBloc.purchase();
                },
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, DeliveryStateLoaded state) {
    return Container(
      height: 162,
      padding: EdgeInsets.only(left: 26),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                'Contact Info',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.caption,
                  color: NokNokColors.contactInfo),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Name:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        color: NokNokColors.mainThemeColor),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    child: Text(
                      'Phone number:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        color: NokNokColors.mainThemeColor),
                    )
                  ),
                  SizedBox(height: 8,),
                  Container(
                    child: Text(
                      'Email:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        color: NokNokColors.mainThemeColor),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      state.userName,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        fontWeight: FontWeight.bold,
                        color: NokNokColors.contactInfo),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    child: Text(
                      state.phoneNumber,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        fontWeight: FontWeight.bold,
                        color: NokNokColors.contactInfo),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    child: Text(
                      state.email,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: NokNokFonts.caption,
                        fontWeight: FontWeight.bold,
                        color: NokNokColors.contactInfo),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // Internal fields

  final DeliveryBloc _deliveryBloc;

  static const _HeaderHeight = 90.0;
  static const _FooterHeight = 135.0;

}
