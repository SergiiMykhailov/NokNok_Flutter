import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/models/store_delivery_time_slot.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/delivery_time_screen/routing/delivery_time_router.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/utils/utils.dart';

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
    return buildScreenWidget(
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

  Widget _buildBody(
    {@required BuildContext context,
    @required DeliveryTimeStateLoaded state}) {
    return ListView.builder(
      itemCount: state.timeSlotRows.length,
      itemBuilder: (BuildContext context, int index) {
        final timeSlotRow = state.timeSlotRows[index];
        return _buildTimeSlotRow(context, timeSlotRow);
      }
    );
  }

  Widget _buildTimeSlotRow(BuildContext context, DeliveryTimeSlotRowInfo rowInfo) {
    if (rowInfo.title != null) {
      return _buildTimeSlotHeader(rowInfo.title);
    }
    else if (rowInfo.timeSlots != null) {
      return _buildTimeSlotsRow(context, rowInfo.timeSlots);
    }

    return Container();
  }

  Widget _buildTimeSlotHeader(String title) {
    if (title == null) {
      return Container(height: _SectionHeaderHeight);
    }

    return Container(
      height: _SectionHeaderHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            height: 22,
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.caption,
                  color: NokNokColors.mainThemeColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimeSlotsRow(BuildContext context, BuiltList<DeliveryTimeSlot> rowTimeSlots) {
    var children = List<Widget>();
    final rowWidth = MediaQuery.of(context).size.width;
    final timeSlotWidgetWidth = rowWidth / DeliveryTimeBloc.NumberOfItemsPerRow - 3 * _TimeSlotsSpacing;

    children.add(SizedBox(width: _TimeSlotsSpacing));

    for (final timeSlot in rowTimeSlots) {
      children.add(SizedBox(width: _TimeSlotsSpacing));
      children.add(_buildTimeSlotWidget(timeSlot,
                                        timeSlotWidgetWidth,
                                        onPressed: () {
        _deliveryTimeBloc.purchase(timeSlot);
      }));
      children.add(SizedBox(width: _TimeSlotsSpacing));
    }

    children.add(SizedBox(width: _TimeSlotsSpacing));

    return Container(
      height: _TimeSlotsSectionHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTimeSlotWidget(DeliveryTimeSlot timeSlot,
                              double width,
                              {@required VoidCallback onPressed}) {
    final timeSlotText = '${timeSlot.timeSlotStart} - ${timeSlot.timeSlotEnd}';

    return Container(
      height: _TimeSlotsSectionHeight - 2 * _TimeSlotsSpacing,
      width: width,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.all(Radius.circular(CornerRadiusLarge)),
      ),
      child: CupertinoButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timeSlotText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: NokNokFonts.productPrice,
                color: NokNokColors.mainThemeColor),
            )
          ],
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }

  Widget _buildFooter({@required BuildContext context,
    @required DeliveryTimeStateLoaded state}) {
    return Column(
      children: [
        SizedBox(height: 47,),
        Row(
          children: [
            Expanded(child: Container(),),
            Container(
              height: 51,
              child: Text(
                'Total cost: ' + formatPrice(state.basket.totalCost),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: NokNokFonts.caption,
                    fontWeight: FontWeight.bold,
                    color: NokNokColors.mainThemeColor),
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

  static const _SectionHeaderHeight = 48.0;
  static const _TimeSlotsSectionHeight = 100.0;
  static const _TimeSlotsSpacing = 2.0;

}