import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class SmartRefresherWidget extends StatelessWidget {
  const SmartRefresherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text(AppStrings.loading.tr());
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text(AppStrings.failed.tr());
      } else if (mode == LoadStatus.canLoading) {
        body = Text(AppStrings.release.tr());
      } else {
        body = Text(AppStrings.noMoreSecret.tr());
      }
      return Container(
        height: AppSize.s60,
        child: Center(child: body),
      );
    });
  }
}
