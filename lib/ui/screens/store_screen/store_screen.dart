import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_images.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';
import 'package:nok_nok/ui/widgets/button_with_icon_and_subtitle.dart';
import 'package:nok_nok/ui/widgets/products_list/compact_products_list_widget.dart';
import 'package:nok_nok/ui/widgets/search_bar.dart';

import 'package:nok_nok/ui/utils/utils.dart';

import 'package:nok_nok/models/store_category_item.dart';
import 'package:nok_nok/models/store_product_base.dart';
import 'package:nok_nok/data_access/repositories/base/store_repository.dart';

import 'bloc/store_bloc.dart';
import 'bloc/store_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:built_collection/built_collection.dart';

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
  void initState() {
    super.initState();

    _searchBarController.addListener(() {

    });
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
            // Nothing to do at the moment.
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
    if (state is StoreStateBaseProductsLoaded) {
      return _buildStoreScreen(context, state.categoryItems, state.products);
    }
    else {
      return buildLoadingWidget(context, "Loading store items...");
    }
  }

  Widget _buildStoreScreen(BuildContext context,
                           BuiltList<StoreCategoryItem> categoryItems,
                           BuiltList<StoreProductBase> products) {
    assert(categoryItems != null, "Invalid parameter value: 'categoryItems'");

    return buildScreenWidget(
      buildContext: context,
      headerHeight: _HeaderHeight,
      footerHeight: _FooterHeight,
      buildHeaderCallback: (BuildContext context) {
        return _buildHeader(context: context);
      },
      buildBodyCallback: (BuildContext context) {
        return _buildBody(context: context, products: products);
      },
      buildFooterCallback: (BuildContext context) {
        return _buildFooter(context: context);
      });
  }

  Widget _buildHeader({@required BuildContext context}) {
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
                          'All products',
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

            CupertinoButton(
              child: Container(
                  width: 29,
                  height: 26,
                  child: ImageIcon(NokNokImages.basket,
                      color: NokNokColors.mainThemeColor)),
              onPressed: () {},
            ),

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
                     @required BuiltList<StoreProductBase> products}) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: _BodyHorizontalInset),
          Expanded(
            child: _buildProductsWidget(context, products)
          ),
          SizedBox(width: _BodyHorizontalInset)
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
            subtitle: "Orders history",
            color: NokNokColors.mainThemeColor,
            onPressed: () {

            },
          ),
          Expanded(
            child: Container(),
          ),
          ButtonWithIconAndSubtitle(
            icon: NokNokImages.deliveryTime,
            subtitle: "Delivery time",
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
      return CompactProductsListWidget(products);
    }
  }

  Widget _buildProductsLoadingWidget(BuildContext context) {
    return buildLoadingWidget(context, "Loading products list...");
  }

  // Internal fields

  final _storeBloc;
  final _searchBarController = TextEditingController();
  final _focusNode = FocusNode();

  static const _HeaderHeight = 130.0;
  static const _FooterHeight = 95.0;
  static const _BodyHorizontalInset = 10.0;

}
