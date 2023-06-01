import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/video_call_screen.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/voice_call_screen.dart';

import '../../../../core/ui/loader.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../profile_details/presentation/trainer_profile_controller/trainer_profile_cubit.dart';
import '../data/model/chat_model.dart';
import '../data/model/message_model.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatDetailsView extends StatefulWidget {
  final ChatModel? chatModel;

  const ChatDetailsView({Key? key, this.chatModel}) : super(key: key);

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final messageController = TextEditingController();

  Future<void> sendMessage() async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatModel!.traineeId.toString() +
            AppStorage.getUserId.toString())
        .set({
      "traineeId": widget.chatModel!.traineeId,
      "traineeImage": widget.chatModel!.traineeImage,
      "traineeName": widget.chatModel!.traineeName,
      "trainerId": AppStorage.getUserId,
      "trainerImage":
          TrainerProfileCubit.of(context).trainerModel!.imageUrl ?? "",
      "trainerName": TrainerProfileCubit.of(context).trainerModel!.name ?? "",
      "id": widget.chatModel!.traineeId.toString() +
          AppStorage.getUserId.toString(),
    });
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatModel!.traineeId.toString() +
            AppStorage.getUserId.toString())
        .collection("messages")
        .doc()
        .set({
      "message": messageController.text,
      "senderId": AppStorage.getUserId,
      "receiverId": widget.chatModel!.traineeId,
      "messageTime": DateTime.now().toString(),
      "type" : "message"
    });
  }
  final ImagePicker picker = ImagePicker();

  Future<void> _uploadImage(File image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Images')
        .child(image.path.split("/").last);
    UploadTask uploadTask = storageReference.putFile(image);

    await Future.value(uploadTask);

    var newUrl = await storageReference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatModel!.traineeId.toString() +
        AppStorage.getUserId.toString())
        .collection("messages")
        .doc()
        .set({
      "message": newUrl,
      "senderId": AppStorage.getUserId,
      "receiverId": widget.chatModel!.traineeId,
      "messageTime": DateTime.now().toString(),
      "type" : "file"
    });  }

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
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return VoiceCallScreen(channelName:widget.chatModel!.traineeId.toString() +AppStorage.getUserId.toString(),);
                    }));
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.accentColorLight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 1,
                    color: AppColors.white,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return VideoCallScreen(channelName:widget.chatModel!.traineeId.toString() +AppStorage.getUserId.toString(),);
                      }));
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
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatModel!.traineeId.toString() +
              AppStorage.getUserId.toString())
          .collection("messages")
          .orderBy("messageTime", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(child: Loader());
        } else {
          List<MessageModel> messages = [];
          for (var element in snapshot.data!.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
          return Expanded(
              child: ListView.separated(
                  reverse: true,
                  itemBuilder: (context, index) {
                    if (messages[index].senderId == AppStorage.getUserId) {
                      if(messages[index].type == "message") {
                        return ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 20),
                          backGroundColor: Colors.blue,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              messages[index].message ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      else{
                        return ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 20),
                          backGroundColor: Colors.blue,
                          child: Image.network(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.7,
                              fit: BoxFit.cover,
                              messages[index].message ?? ""),
                        );
                      }
                    } else {
                      if(messages[index].type != "file") {
                        return ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                          backGroundColor: const Color(0xffE7E7ED),
                          margin: const EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              messages[index].message ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }else{
                        return ChatBubble(
                          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                          backGroundColor: const Color(0xffE7E7ED),
                          margin: const EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Image.network(
                              messages[index].message ?? "",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: messages.length));
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(
        title: "الرسائل",
      ),
      body: Column(
        children: [callingForm(), chatText(),Container(
            decoration: BoxDecoration(
                color: AppColors.transparent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (messageController.text.isNotEmpty) {
                      await sendMessage();
                    }
                    messageController.clear();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: AppColors.white,
                  ),
                ),
                Expanded(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async{
                        var file = await picker.pickImage(source: ImageSource.gallery);
                        if(file != null){
                          _uploadImage(File(file.path));
                        }
                      },
                      icon: const Icon(
                        FontAwesomeIcons.paperclip,
                        color: AppColors.white,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     FontAwesomeIcons.faceSmile,
                    //     color: AppColors.white,
                    //   ),
                    // )
                  ],
                )
              ],
            ))],
      ),

    );
  }
}
