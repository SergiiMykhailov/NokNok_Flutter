import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nok_nok/ui/routing/build_context_provider.dart';
import 'package:nok_nok/ui/screens/sign_in_screen/routing/sign_in_screen_router.dart';

import 'package:flutter/cupertino.dart';
import 'package:nok_nok/ui/theme/nok_nok_colors.dart';
import 'package:nok_nok/ui/theme/nok_nok_theme.dart';
import 'package:nok_nok/ui/utils/screen_utils.dart';

import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_state.dart';

class SignInScreen extends StatefulWidget {

  // Public methods and properties

  SignInScreen(SignInScreenRouter router,
    {Key key})
    : _router = router,
      super(key: key);

  // Overridden methods

  @override
  _SignInScreenState createState() => _SignInScreenState(_router);

  // Internal fields

  final SignInScreenRouter _router;

}

class _SignInScreenState extends State<SignInScreen>
  with BuildContextProvider {

  // Public methods and properties

  _SignInScreenState(SignInScreenRouter router,
    {Key key})
    : _signInBloc = SignInBloc(router),
      super() {
    _signInBloc.buildContextProvider = this;
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
          bloc: _signInBloc,
          // BlocBuilder invokes the builder when new state is emitted.
          child: BlocBuilder(
            bloc: _signInBloc,
            // The builder function has to be a "pure function".
            // That is, it only returns a Widget and doesn't do anything else.
            builder: (BuildContext context, SignInState state) {
              return _buildScreen(context, state);
            },
          ),
          // Listener is the place for logging, showing Snackbars, navigating, etc.
          // It is guaranteed to run only once per state change.
          listener: (BuildContext context, SignInState state) {
          },
        )
      ),
    );
  }

  @override
  void dispose() {
    _signInBloc.dispose();

    super.dispose();
  }

  // Internal methods

  Widget _buildScreen(BuildContext context, SignInState state) {
    if (state is SignInStateLoading) {
      return buildLoadingWidget(context, "Signing in...");
    }
    else if (state is SignInStateLoaded) {
      return _buildSignInScreen(context);
    }
    else {
      return Container();
    }
  }

  Widget _buildSignInScreen(BuildContext context) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Container(
              child: Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: NokNokFonts.caption,
                fontWeight: FontWeight.bold,
                color: NokNokColors.mainThemeColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody({@required BuildContext context}) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: DefaultBodyHorizontalInset),
          Expanded(
            child: Container(

            )
          ),
          SizedBox(width: DefaultBodyHorizontalInset)
        ],
      ),
    );
  }

  Widget _buildFooter({@required BuildContext context}) {
    return Container();
  }

  // Internal fields

  final SignInBloc _signInBloc;

}
