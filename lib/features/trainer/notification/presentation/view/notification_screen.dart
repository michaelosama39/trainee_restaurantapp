import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';

import '../../../../../core/ui/widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const TransparentAppBar(
        title: "الاشعارات",
    ),
      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.white,
              thickness: 2,
            );
          },
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: NotificationItem(),
            );
          }),
    );
  }
}


class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CircleAvatar(backgroundImage: AssetImage(AppConstants.COACH3_IMAGE),),
        SizedBox(width: 10,),
        Expanded(child: Text("hello",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        SizedBox(width: 10,),
        Text("12/03/2010",style: TextStyle(color: Colors.white,fontSize: 14),)
      ],
    );
  }
}

