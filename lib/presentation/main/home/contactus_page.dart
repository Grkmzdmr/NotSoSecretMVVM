import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
    title: Text(
      "About Us",
      style: Theme.of(context).textTheme.headline2,
    ),
    
      ),
      body: Container(
        child: Column(
          children: [
            
          ],
        ),
      ),
      
    );
  }
}