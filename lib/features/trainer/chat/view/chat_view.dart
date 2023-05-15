import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/data/model/chat_model.dart';

import '../../../../core/appStorage/app_storage.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import 'chat_details_view.dart';

class ChatView extends StatelessWidget {
   ChatView({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> chatsCollection = FirebaseFirestore.instance.collection('chats').snapshots();


  horizontalListView() {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: const DecorationImage(
                      image: AssetImage(
                        AppConstants.TRAINEE_IMG,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        text: "رامي المصرى",
                        fontWeight: FontWeight.w700,
                        fontSize: AppConstants.textSize10),
                    CustomText(
                      text: "متدرب كورس أثقال",
                      fontWeight: FontWeight.w700,
                      fontSize: AppConstants.textSize10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  verticalListView() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatsCollection,
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.none) {
        return const Text('Something went wrong');
      }

      else if (snapshot.connectionState == ConnectionState.waiting) {
        return const Loader();
      }else{
        List<ChatModel> chats = [];
        for (var element in snapshot.data!.docs) {
          print(element.data());
          if(element.data()["trainerId"] == AppStorage.getUserId){
            chats.add(ChatModel.fromJson(element.data()));
          }
        }
        return Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsView(chatModel: chats[index]),));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 90.h,
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              height: 95.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.h),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    chats[index].traineeImage ?? "",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w,),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: chats[index].traineeName ?? "",
                                      fontSize: AppConstants.textSize18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            textAlign: TextAlign.start,
                                            text: chats[index].messages!.last.message ?? "",
                                            textOverflow: TextOverflow.ellipsis,
                                            fontSize: AppConstants.textSize14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        CustomText(
                                          text: chats[index].messages!.last.messageTime ?? "",
                                          fontSize: AppConstants.textSize14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    color: AppColors.white,
                  );
                },
                itemCount: chats.length));
      }

    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(
        title: "تبي تواصل معا متدربك؟",
      ),
      body: Column(
        children: [
          horizontalListView(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppColors.white,
            ),
          ),
          verticalListView()
        ],
      ),
    );
  }
}
