import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/data/data_source/local_data_source.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    String _title = AppStrings.settings.tr();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.headline3,
            ),
            leading: Icon(Icons.language),
            trailing: Icon(Icons.arrow_forward_ios, size: AppSize.s20),
            onTap: () {
              showAlertDialog(context);
            },
          ),
          ListTile(
            title: Text(AppStrings.contactUs.tr(),
                style: Theme.of(context).textTheme.headline3),
            leading: Icon(Icons.people),
            trailing: Icon(Icons.arrow_forward_ios, size: AppSize.s20),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            title: Text(AppStrings.inviteFriends.tr(),
                style: Theme.of(context).textTheme.headline3),
            leading: Icon(Icons.share),
            trailing: Icon(Icons.arrow_forward_ios, size: AppSize.s20),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            title: Text(AppStrings.logOut.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.red)),
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: AppSize.s20,
              color: Colors.red,
            ),
            onTap: () {
              showAlertDialogLogOut(context);
            },
          )
        ],
      ),
    );
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context); //restart to apply language changes
  }

  void _contactUs() {
    Navigator.pushNamed(context, Routes.aboutusRoute);
  }

  void _inviteFriends() {}
  void _logOut() {
    _appPreferences.logout();

    _localDataSource.clearCache();

    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }

  showAlertDialog(BuildContext context) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          _changeLanguage();
        },
        child: Text(AppStrings.yes.tr(),
            style: Theme.of(context).textTheme.bodyText2));
    Widget notsureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.no.tr(),
          style: Theme.of(context).textTheme.bodyText2,
        ));

    AlertDialog alertDialog = AlertDialog(
      titlePadding: EdgeInsets.only(left: AppSize.s30, top: AppSize.s20),
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s24))),
      title: Text(
        AppStrings.language.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        AppStrings.surechangelanguage.tr(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [sureButton, notsureButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  showAlertDialogLogOut(BuildContext context) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          _logOut();
        },
        child: Text(AppStrings.yes.tr(),
            style: Theme.of(context).textTheme.bodyText2));
    Widget notsureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.no.tr(),
          style: Theme.of(context).textTheme.bodyText2,
        ));

    AlertDialog alertDialog = AlertDialog(
      titlePadding: EdgeInsets.only(left: AppSize.s30, top: AppSize.s20),
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s24))),
      title: Text(
        AppStrings.logOut.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        AppStrings.surelogout.tr(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: [sureButton, notsureButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
