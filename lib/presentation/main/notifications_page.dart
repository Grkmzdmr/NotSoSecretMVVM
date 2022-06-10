import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({ Key? key }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.notification.tr()),
      
    );
  }
}