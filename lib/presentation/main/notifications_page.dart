import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    String _title = AppStrings.notification.tr();
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.headline2?.copyWith(color: ColorManager.primary),),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: ColorManager.primary,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: 
        SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode){
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
          height: 55.0,
          child: Center(child: body),
        );
          }),
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: (){},
          onLoading: (){},
          child: ListView(
        
            children: [
              ListTile(
              leading: Icon(Icons.comment,size: AppSize.s30,),
              title: Text("Yorum"),
              subtitle: Text("loriini gönderinize yorum yaptı."),
            ),
             ListTile(
              leading: Icon(Icons.comment,size: AppSize.s30,),
              title: Text("Yorum"),
              subtitle: Text("grkm gönderinize yorum yaptı."),
            ),
            
            ]
          ),
        ),
      
    );
  }
}
