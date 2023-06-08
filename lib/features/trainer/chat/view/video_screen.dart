import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../home_trainer/presentation/home_trainer_controller/home_trainer_cubit.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({Key? key, required this.traineeId}) : super(key: key);
  final int traineeId;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 172297515, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "7088d2ea9432e77970a85beeb177953cbee5b6a7b41845280e1a1c4d39ac813e", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: AppStorage.getUserId.toString(),
      userName: HomeTrainerCubit.of(context)
          .trainee!.trainee!.name ?? "",
      callID: AppStorage.getUserId.toString()+ traineeId.toString(),
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}