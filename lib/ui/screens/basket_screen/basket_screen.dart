import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/basket_screen/routing/basket_router.dart';

import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/basket_list/basket_list.dart';
import 'package:nok_nok/ui/widgets/total_cost_widget.dart';

import 'bloc/basket_bloc.dart';
import 'bloc/basket_state.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/widgets.dart';

class BasketScreen extends StatefulWidget {
  // Public methods and properties

  BasketScreen(StoreRepository storeRepository,
               BasketScreenRouter router,
               {Key key})
      : _storeRepository = storeRepository,
        _router = router,
        super(key: key);

  // Overridden methods

  @override
  _BasketScreenState createState() =>
    _BasketScreenState(_storeRepository, _router);

  // Internal fields

  final StoreRepository _storeRepository;
  final BasketScreenRouter _router;
}

class _BasketScreenState extends State<BasketScreen>
                         with BuildContextProvider {
  // Public methods and properties

  _BasketScreenState(StoreRepository storeRepository,
                     BasketScreenRouter router,
                     {Key key})
      : _basketBloc = BasketBloc(storeRepository, router),
        super() {
    _basketBloc.buildContextProvider = this;
  }

  // Overridden methods

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: SafeArea(
        child: BlocListener(
          bloc: _basketBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _basketBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, BasketState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, BasketState state) {
          },
        )
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  void dispose() {
    _basketBloc.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, BasketState state) {
    if (state is BasketStateLoaded) {
      return _buildBasketScreen(context, state);
    } else {
      return buildLoadingWidget(context, "Loading basket items...");
    }
  }

  Widget _buildBasketScreen(BuildContext context, BasketStateLoaded state) {
    return buildScreenWidget(
        buildContext: context,
        headerHeight: _HeaderHeight,
        footerHeight: _FooterHeight,
        buildHeaderCallback: (BuildContext context) {
          return _buildHeader(context: context, state: state);
        },
        buildBodyCallback: (BuildContext context) {
          return _buildBody(context: context, state: state);
        },
        buildFooterCallback: (BuildContext context) {
          return _buildFooter(context: context, state: state);
        });
  }

  Widget _buildHeader(
      {@required BuildContext context,
       @required BasketStateLoaded state}) {
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
            _basketBloc.navigateBack();
          },
        ),
        Expanded(
          child: Center(
            child: Container(
              child: Text(
                'Basket',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: NokNokFonts.caption,
                  fontWeight: FontWeight.bold,
                  color: NokNokColors.mainThemeColor),
              ),
            ),
          ),
        ),
        CupertinoButton(
          child: Container(
            width: 24,
            height: 24,
            child: ImageIcon(NokNokImages.ordersHistory,
              color: NokNokColors.mainThemeColor)),
          onPressed: () {},
        ),
        SizedBox(width: 3),
      ],
    );
  }

  Widget _buildBody(
      {@required BuildContext context, @required BasketStateLoaded state}) {

      return Row(
        children: [
          SizedBox(width: DefaultBodyHorizontalInset),
          Expanded(
            child: BasketListWidget(
              state.basket,
              onItemAppended: (int itemIndex) {
                _handleAppendItemWithIndex(itemIndex);
              },
              onItemDecreased: (int itemIndex) {
                _handleDecrementItemWithIndex(itemIndex);
              },
              onItemRemoved: (int itemIndex) {
                _handleRemoveItemWithIndex(itemIndex);
              },
            )
          ),
          SizedBox(width: DefaultBodyHorizontalInset)
        ],
      );
  }

  Widget _buildFooter({@required BuildContext context,
                       @required BasketStateLoaded state}) {
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
                onPurchaseClicked: () {},
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
      ],
    );
  }

  void _handleAppendItemWithIndex(int itemIndex) {
    _basketBloc.appendItemWithIndex(itemIndex);
  }

  void _handleDecrementItemWithIndex(int itemIndex) {
    _basketBloc.decrementItemWithIndex(itemIndex);
  }

  void _handleRemoveItemWithIndex(int itemIndex) {
    _basketBloc.removeItemWithIndex(itemIndex);
  }

  // Internal fields

  final BasketBloc _basketBloc;

  static const _HeaderHeight = 90.0;
  static const _FooterHeight = 135.0;

}