import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/data/model/chat_model.dart';
import 'package:trainee_restaurantapp/features/trainer/home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';
import '../../../../core/appStorage/app_storage.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import 'chat_details_view.dart';
import '../data/model/message_model.dart';

class ChatView extends StatelessWidget {
   ChatView({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> chatsCollection = FirebaseFirestore.instance.collection('chats').snapshots();


  horizontalListView() {
    return BlocBuilder<HomeTrainerCubit,HomeTrainerState>(
      builder: (context, state) {
      if(state is GetNewTraineesLoading){
        return const Loader();
      }else{
        return SizedBox(
          height: 120.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: HomeTrainerCubit.of(context).newTrainees!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsView(chatModel: ChatModel(
                          traineeId: HomeTrainerCubit.of(context).newTrainees![index].traineeId,
                          traineeImage: HomeTrainerCubit.of(context).newTrainees![index].trainee!.imageUrl ?? "",
                          traineeName: HomeTrainerCubit.of(context).newTrainees![index].trainee!.name,
                          )),));
                    },
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                            image: NetworkImage(
                              HomeTrainerCubit.of(context).newTrainees![index].trainee!.imageUrl ?? "",
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                              text: HomeTrainerCubit.of(context).newTrainees![index].trainee!.name ?? "",
                              fontWeight: FontWeight.w700,
                              fontSize: AppConstants.textSize10),
                          CustomText(
                            text: HomeTrainerCubit.of(context).newTrainees![index].course!.text ?? "",
                            fontWeight: FontWeight.w700,
                            fontSize: AppConstants.textSize10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    },);
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
                                    StreamBuilder
                                      (
                                      stream: FirebaseFirestore.instance.collection('chats').doc(chats[index].traineeId.toString() + AppStorage.getUserId.toString()).collection("messages").orderBy("messageTime",descending: false).snapshots(),
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.active){
                                          MessageModel message = MessageModel.fromJson(snapshot.data!.docs.last.data());
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: CustomText(
                                                  textAlign: TextAlign.start,
                                                  text: message.message ?? "",
                                                  textOverflow: TextOverflow.ellipsis,
                                                  fontSize: AppConstants.textSize14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              CustomText(
                                                text: message.messageTime!.substring(0,10),
                                                fontSize: AppConstants.textSize14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.grey,
                                              ),
                                            ],
                                          );
                                        }else if(snapshot.connectionState == ConnectionState.waiting){
                                          return const SizedBox();
                                        }return const SizedBox();
                                      },)
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
