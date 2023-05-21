


import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

import 'agoraConfig.dart';

class VideoCallScreen extends StatefulWidget {

  const VideoCallScreen({Key? key,}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: AgoraConstants.appId,
      channelName: AgoraConstants.channelName,
      tempToken: AgoraConstants.token,
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora VideoUIKit'),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Stack(
              children: [
                AgoraVideoViewer(
                  client: client,
                  layoutType: Layout.floating,
                  enableHostControls: true, // Add this to enable host controls
                ),
                AgoraVideoButtons(
                  client: client,
                  enabledButtons: const [
                    BuiltInButtons.toggleCamera,
                    BuiltInButtons.callEnd,
                    BuiltInButtons.toggleMic,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
