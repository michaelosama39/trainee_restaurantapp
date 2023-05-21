import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/video_call.dart';

import '../../../../core/ui/loader.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';
import '../data/model/chat_model.dart';
import '../data/model/message_model.dart';

class ChatDetailsView extends StatefulWidget {
  final ChatModel? chatModel;
  const ChatDetailsView({Key? key, this.chatModel}) : super(key: key);

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {

  final messageController = TextEditingController();

  void sendMessage()async{
    widget.chatModel!.messages!.add(MessageModel(AppStorage.getUserId,widget.chatModel!.traineeId, messageController.text, DateTime.now().toString()));
    await FirebaseFirestore.instance.collection('chats').doc(widget.chatModel!.traineeId.toString() + AppStorage.getUserId.toString()).set({
      "traineeId" : widget.chatModel!.traineeId,
      "traineeImage" : widget.chatModel!.traineeImage,
      "traineeName" : widget.chatModel!.traineeName,
      "trainerId" : AppStorage.getUserId,
      "trainerImage" : TrainerProfileCubit.of(context).trainerModel!.imageUrl ?? "",
      "trainerName" : TrainerProfileCubit.of(context).trainerModel!.name ?? "",
      "id" : widget.chatModel!.traineeId.toString() + AppStorage.getUserId.toString(),
      "messages" : widget.chatModel!.messages!.map((e){
        return {
          "message" : e.message,
          "senderId" : e.senderId,
          "receiverId" : e.receiverId,
          "messageTime" : e.messageTime
        };
      }).toList()
    });
  }


  callingForm() {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.transparent.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: CustomText(
                text: widget.chatModel!.traineeName ?? "",
                fontWeight: FontWeight.w700,
                fontSize: AppConstants.textSize18,
              )),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.chatModel!.traineeImage ?? ""),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: AppColors.accentColorLight,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 1,
                    color: AppColors.white,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return const VideoCallScreen(channelName: '',);
                      // }));
                    },
                    icon: const Icon(
                      Icons.videocam,
                      color: AppColors.accentColorLight,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  chatText() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatModel!.traineeId.toString() + AppStorage.getUserId.toString()).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text('Something went wrong');
        }

        else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }else{
          print(snapshot.data!.data());


if(snapshot.data!.data() != null){
  List<MessageModel> messages = [];
  for (var element in snapshot.data!.data()?["messages"]) {
    messages.add(MessageModel.fromJson(element));
  }
  return Expanded(child: ListView.separated(itemBuilder: (context, index) {
    if(messages[index].senderId == AppStorage.getUserId){
      return Container(
        padding: const EdgeInsets.all(10),
        child: Text(messages[index].message ?? ""),);
    }else{
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(messages[index].message ?? ""),),
      );
    }
  }, separatorBuilder: (context, index) {
    return const SizedBox(height: 10,);
  }, itemCount: messages.length));
}else{
  return const SizedBox();
}

        }
    },);

  }

  chatEnterField() {
    return Expanded(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.transparent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.telegram,
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter text here',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.file_copy_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions_outlined))
                    ],
                  ))
            ],
          )),
    );
  }

  chatFloatingActionButton() {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.transparent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  if(messageController.text.isNotEmpty){
                    sendMessage();
                  }
                  messageController.clear();
                },
                icon: const Icon(
                  FontAwesomeIcons.paperPlane,
                  color: AppColors.white,
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter text here',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.paperclip,
                        color: AppColors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.faceSmile,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(
        title: "الرسائل",
      ),
      body: Column(
        children: [callingForm(), chatText()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: chatFloatingActionButton(),
    );
  }
}
