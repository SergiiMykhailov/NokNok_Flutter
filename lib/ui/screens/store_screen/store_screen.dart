import 'package:nok_nok/ui/localization/nok_nok_localization.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/store_screen/routing/store_screen_router.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/action_button.dart';
import 'package:nok_nok/ui/widgets/basket_button.dart';
import 'package:nok_nok/ui/widgets/button_with_icon_and_subtitle.dart';
import 'package:nok_nok/ui/widgets/products_list/compact_products_list_widget.dart';
import 'package:nok_nok/ui/widgets/search_bar.dart';

import 'package:nok_nok/models/store_product_base.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';
import 'package:nok_nok/ui/widgets/total_cost_widget.dart';

import 'bloc/store_bloc.dart';
import 'bloc/store_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:built_collection/built_collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {

  // Public methods and properties

  StoreScreen(StoreRepository storeRepository,
              StoreScreenRouter router,
              {Key key})
   : _storeRepository = storeRepository,
     _router = router,
      super(key: key);

  // Overridden methods

  @override
  _StoreScreenState createState() => _StoreScreenState(_storeRepository, _router);

  // Internal fields

  final StoreRepository _storeRepository;
  final StoreScreenRouter _router;

}

class _StoreScreenState extends State<StoreScreen>
                        with BuildContextProvider {

  // Public methods and properties

  _StoreScreenState(StoreRepository storeRepository,
                    StoreScreenRouter router,
                    {Key key})
    : _storeBloc = StoreBloc(storeRepository, router),
      super() {
    _storeBloc.buildContextProvider = this;
  }

  // Overridden methods

  @override
  void initState() {
    super.initState();

    _searchBarController.addListener(() {

    });
  }

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
          bloc: _storeBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _storeBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, StoreState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, StoreState state) {
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _storeBloc.dispose();
    _searchBarController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, StoreState state) {
    if (state is StoreStateLoaded) {
      return _buildStoreScreen(
        context,
        state.totalItemsInBasket,
        state.totalCost,
        state.products);
    }
    else {
      return buildLoadingWidget(context, translate(context, "Loading store items..."));
    }
  }

  Widget _buildStoreScreen(BuildContext context,
                           int totalItemsInBasket,
                           double totalCost,
                           BuiltList<StoreProductBase> products) {
    return buildScreenWidget(
      buildContext: context,
      headerHeight: DefaultHeaderHeight,
      footerHeight: DefaultFooterHeight,
      buildHeaderCallback: (BuildContext context) {
        return _buildHeader(context: context, totalItemsInBasket: totalItemsInBasket);
      },
      buildBodyCallback: (BuildContext context) {
        return _buildBody(context: context, products: products, totalCost: totalCost);
      },
      buildFooterCallback: (BuildContext context) {
        return _buildFooter(context: context);
      });
  }

  Widget _buildHeader({@required BuildContext context,
                       @required int totalItemsInBasket}) {
    _basketButton.itemsCount = totalItemsInBasket;
    _basketButton.onPressed = () {
      _storeBloc.purchase();
    };

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),

            CupertinoButton(
              child: Container(
                  width: 23,
                  height: 26,
                  child: ImageIcon(NokNokImages.mainMenu,
                      color: NokNokColors.mainThemeColor)
              ),
              onPressed: () {},
            ),
            Expanded(
              child: Center(
                child: Container(
                  child: CupertinoButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translate(context, 'All products'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: NokNokFonts.caption,
                              fontWeight: FontWeight.bold,
                              color: NokNokColors.mainThemeColor),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 10,
                          height: 21,
                          child: ImageIcon(
                            NokNokImages.dropDown,
                            color: NokNokColors.mainThemeColor),
                        ),
                      ],
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ),
            ),

            _basketButton,

            SizedBox(width: 10),
          ],
        ),

        Container(
          height: 50,
          child: Row(
            children: [
              SizedBox(width: 17, height: 36),
              Expanded(
                child: SearchBar(
                  controller: _searchBarController,
                  focusNode: _focusNode,
                ),
              ),
              CupertinoButton(
                child: Container(
                  width: 29,
                  height: 44,
                  child: ImageIcon(NokNokImages.sortAscending,
                    color: NokNokColors.mainThemeColor)),
                onPressed: () {},
              ),
              SizedBox(width: 7)
            ],
          ),
        )

      ],
    );
  }

  Widget _buildBody({@required BuildContext context,
                     @required BuiltList<StoreProductBase> products,
                     @required double totalCost}) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: DefaultBodyHorizontalInset),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _buildProductsWidget(context, products),
                ),
                _buildTotalCostWidget(context, totalCost)
              ],
            )
          ),
          SizedBox(width: DefaultBodyHorizontalInset)
        ],
      ),
    );
  }

  Widget _buildFooter({@required BuildContext context}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          ButtonWithIconAndSubtitle(
            icon: NokNokImages.ordersHistory,
            subtitle: translate(context, "Orders history"),
            color: NokNokColors.mainThemeColor,
            onPressed: () {

            },
          ),
          Expanded(
            child: Container(),
          ),
          ButtonWithIconAndSubtitle(
            icon: NokNokImages.deliveryTime,
            subtitle: translate(context, "Delivery time"),
            color: NokNokColors.mainThemeColor,
            onPressed: () {

            },
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsWidget(BuildContext context,
                              BuiltList<StoreProductBase> products) {
    if (products == null) {
      return _buildProductsLoadingWidget(context);
    }
    else {
      return Row(
        children: [
          SizedBox(width: DefaultBodyHorizontalInset),
          Expanded(
            child: CompactProductsListWidget(
              products,
              onItemAppended: (int itemIndex) {
                _handleAppendItemWithIndex(itemIndex);
              },
            )
          ),
          SizedBox(width: DefaultBodyHorizontalInset)
        ],
      );
    }
  }

  Widget _buildTotalCostWidget(BuildContext context,
                               double totalCost) {
    final canPurchase = totalCost > 0;
    final purchaseWidgetHeight = canPurchase ? _PurchaseWidgetHeight : 0.0;

    return AnimatedContainer(
      duration: Duration(milliseconds: DefaultAnimationDuration),
      curve: Curves.fastOutSlowIn,
      height: purchaseWidgetHeight,
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CornerRadiusLarge),
            topRight: Radius.circular(CornerRadiusLarge)
          ),
        ),
        child: Center(
          child: Container(
            height: ButtonHeight,
            child: TotalCostWidget(
              totalCost,
              onPurchaseClicked: () {
                _storeBloc.purchase();
              },
            ),
          ),
        ),
      )
    );
  }

  Widget _buildProductsLoadingWidget(BuildContext context) {
    return buildLoadingWidget(context, translate(context, "Loading products list..."));
  }

  void _handleAppendItemWithIndex(int itemIndex) {
    _storeBloc.addItemToBasket(itemIndex: itemIndex);
  }

  // Internal fields

  final StoreBloc _storeBloc;
  final _searchBarController = TextEditingController();
  final _focusNode = FocusNode();
  final _basketButton = BasketButton();

  static const _PurchaseWidgetHeight = 115.0;

}
