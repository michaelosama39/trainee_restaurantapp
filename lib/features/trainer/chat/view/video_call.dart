// import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'agoraConfig.dart ' as config;
// import 'log_sink.dart';
//
// class VideoCallView extends StatefulWidget {
//   const VideoCallView({Key? key, required this.channelName}) : super(key: key);
//   final String channelName;
//
//   @override
//   State<VideoCallView> createState() => _VideoCallViewState();
// }
//
// class _VideoCallViewState extends State<VideoCallView> {
//   late RtcEngine rtcEngine;
//   bool loading = false;
//
//   @override
//   void initState() {
//     _initEngine();
//     super.initState();
//   }
//    late final RtcEngine _engine;
//   bool isJoined = false, switchCamera = true, switchRender = true;
//   Set<int> remoteUid = {};
//   late TextEditingController _controller;
//   bool _isUseFlutterTexture = false;
//   bool _isUseAndroidSurfaceView = false;
//   ChannelProfileType _channelProfileType =
//       ChannelProfileType.channelProfileLiveBroadcasting;
//     Future<void> _initEngine() async {
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: config.appId,
//     ));
//
//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onError: (ErrorCodeType err, String msg) {
//         logSink.log('[onError] err: $err, msg: $msg');
//       },
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         logSink.log(
//             '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
//         setState(() {
//           isJoined = true;
//         });
//       },
//       onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
//         logSink.log(
//             '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
//         setState(() {
//           remoteUid.add(rUid);
//         });
//       },
//       onUserOffline:
//           (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
//         logSink.log(
//             '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
//         setState(() {
//           remoteUid.removeWhere((element) => element == rUid);
//         });
//       },
//       onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//         logSink.log(
//             '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
//         setState(() {
//           isJoined = false;
//           remoteUid.clear();
//         });
//       },
//     ));
//
//     await _engine.enableVideo();
//
//     await _engine.setVideoEncoderConfiguration(
//       const VideoEncoderConfiguration(
//         dimensions: VideoDimensions(width: 640, height: 360),
//         frameRate: 15,
//         bitrate: 0,
//       ),
//     );
//   }
//
//     Future<void> _joinChannel() async {
//     await _engine.joinChannel(
//       token: config.token,
//       channelId: _controller.text,
//       uid: config.uid,
//       options: ChannelMediaOptions(
//         channelProfile: _channelProfileType,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//   }
//
//   Future<void> _leaveChannel() async {
//     await _engine.leaveChannel();
//   }
//
//   Future<void> _switchCamera() async {
//     await _engine.switchCamera();
//     setState(() {
//       switchCamera = !switchCamera;
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:,
//     );
//   }
// }
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:trainee_restaurantapp/features/trainer/chat/view/widget.dart';
// import 'agoraConfig.dart' as config;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'log_sink.dart';
//
// /// MultiChannel Example
// class JoinChannelVideo extends StatefulWidget {
//   /// Construct the [JoinChannelVideo]
//   const JoinChannelVideo({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _State();
// }
//
// class _State extends State<JoinChannelVideo> {
//   late final RtcEngine _engine;
//   bool isJoined = false, switchCamera = true, switchRender = true;
//   Set<int> remoteUid = {};
//   late TextEditingController _controller;
//   bool _isUseFlutterTexture = false;
//   bool _isUseAndroidSurfaceView = false;
//   ChannelProfileType _channelProfileType =
//       ChannelProfileType.channelProfileLiveBroadcasting;
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: "yacoatchchannel");
//     _initEngine();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _dispose();
//   }
//
//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }
//
//
//
//   Future<void> _initEngine() async {
//     await [Permission.microphone, Permission.camera].request();
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(
//       appId: config.appId,
//     ));
//
//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onError: (ErrorCodeType err, String msg) {
//         logSink.log('[onError] err: $err, msg: $msg');
//       },
//       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//         logSink.log(
//             '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
//         setState(() {
//           isJoined = true;
//         });
//       },
//       onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
//         logSink.log(
//             '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
//         setState(() {
//           remoteUid.add(rUid);
//         });
//       },
//       onUserOffline:
//           (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
//         logSink.log(
//             '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
//         setState(() {
//           remoteUid.removeWhere((element) => element == rUid);
//         });
//       },
//       onLeaveChannel: (RtcConnection connection, RtcStats stats) {
//         logSink.log(
//             '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
//         setState(() {
//           isJoined = false;
//           remoteUid.clear();
//         });
//       },
//     ));
//
//     await _engine.enableVideo();
//
//     await _engine.setVideoEncoderConfiguration(
//       const VideoEncoderConfiguration(
//         dimensions: VideoDimensions(width: 640, height: 360),
//         frameRate: 15,
//         bitrate: 0,
//       ),
//     );
//   }
//
//   Future<void> _joinChannel() async {
//     await _engine.joinChannel(
//       token: config.token,
//       channelId:"yacoatchchannel",
//       uid: config.uid,
//       options: ChannelMediaOptions(
//         channelProfile: _channelProfileType,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//   }
//
//   Future<void> _leaveChannel() async {
//     await _engine.leaveChannel();
//   }
//
//   Future<void> _switchCamera() async {
//     await _engine.switchCamera();
//     setState(() {
//       switchCamera = !switchCamera;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         body: Stack(
//           children: [
//             AgoraVideoView(
//               controller: VideoViewController(
//                 rtcEngine: _engine,
//                 canvas: const VideoCanvas(uid: 0),
//                 useFlutterTexture: _isUseFlutterTexture,
//                 useAndroidSurfaceView: _isUseAndroidSurfaceView,
//               ),
//               // onAgoraVideoViewCreated: (viewId) {
//               //   _engine.startPreview();
//               // },
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.of(remoteUid.map(
//                         (e) => SizedBox(
//                       width: 120,
//                       height: 120,
//                       child: AgoraVideoView(
//                         controller: VideoViewController.remote(
//                           rtcEngine: _engine,
//                           canvas: VideoCanvas(uid: e),
//                           connection:
//                           RtcConnection(channelId: _controller.text),
//                           useFlutterTexture: _isUseFlutterTexture,
//                           useAndroidSurfaceView: _isUseAndroidSurfaceView,
//                         ),
//                       ),
//                     ),
//                   )),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//       ExampleActionsWidget(
//       displayContentBuilder: (context, isLayoutHorizontal) {
//         return Stack(
//           children: [
//             AgoraVideoView(
//               controller: VideoViewController(
//                 rtcEngine: _engine,
//                 canvas: const VideoCanvas(uid: 0),
//                 useFlutterTexture: _isUseFlutterTexture,
//                 useAndroidSurfaceView: _isUseAndroidSurfaceView,
//               ),
//               // onAgoraVideoViewCreated: (viewId) {
//               //   _engine.startPreview();
//               // },
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: List.of(remoteUid.map(
//                         (e) => SizedBox(
//                       width: 120,
//                       height: 120,
//                       child: AgoraVideoView(
//                         controller: VideoViewController.remote(
//                           rtcEngine: _engine,
//                           canvas: VideoCanvas(uid: e),
//                           connection:
//                           RtcConnection(channelId: _controller.text),
//                           useFlutterTexture: _isUseFlutterTexture,
//                           useAndroidSurfaceView: _isUseAndroidSurfaceView,
//                         ),
//                       ),
//                     ),
//                   )),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//       actionsBuilder: (context, isLayoutHorizontal) {
//         final channelProfileType = [
//           ChannelProfileType.channelProfileLiveBroadcasting,
//           ChannelProfileType.channelProfileCommunication,
//         ];
//         final items = channelProfileType
//             .map((e) => DropdownMenuItem(
//           child: Text(
//             e.toString().split('.')[1],
//           ),
//           value: e,
//         ))
//             .toList();
//
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: const InputDecoration(hintText: 'Channel ID'),
//             ),
//             if (!kIsWeb &&
//                 (defaultTargetPlatform == TargetPlatform.android ||
//                     defaultTargetPlatform == TargetPlatform.iOS))
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   if (defaultTargetPlatform == TargetPlatform.iOS)
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text('Rendered by Flutter texture: '),
//                           Switch(
//                             value: _isUseFlutterTexture,
//                             onChanged: isJoined
//                                 ? null
//                                 : (changed) {
//                               setState(() {
//                                 _isUseFlutterTexture = changed;
//                               });
//                             },
//                           )
//                         ]),
//                   if (defaultTargetPlatform == TargetPlatform.android)
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text('Rendered by Android SurfaceView: '),
//                           Switch(
//                             value: _isUseAndroidSurfaceView,
//                             onChanged: isJoined
//                                 ? null
//                                 : (changed) {
//                               setState(() {
//                                 _isUseAndroidSurfaceView = changed;
//                               });
//                             },
//                           ),
//                         ]),
//                 ],
//               ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text('Channel Profile: '),
//             DropdownButton<ChannelProfileType>(
//               items: items,
//               value: _channelProfileType,
//               onChanged: isJoined
//                   ? null
//                   : (v) {
//                 setState(() {
//                   _channelProfileType = v!;
//                 });
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: ElevatedButton(
//                     onPressed: isJoined ? _leaveChannel : _joinChannel,
//                     child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
//                   ),
//                 )
//               ],
//             ),
//             if (defaultTargetPlatform == TargetPlatform.android ||
//                 defaultTargetPlatform == TargetPlatform.iOS) ...[
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 onPressed: _switchCamera,
//                 child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
//               ),
//             ],
//           ],
//         );
//       },
//     );
//     // if (!_isInit) return Container();
//   }
// }

import 'package:flutter/material.dart';

import 'agoraConfig.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelName;
  const VideoCallScreen({Key? key, required this.channelName}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }
  Future<void> initialize() async {
    if (AgoraConstants.appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const Size(1920, 1080);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(AgoraConstants.appId);
    await AgoraRtcEngine.enableVideo();
  }
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
        String channel,
        int uid,
        int elapsed,
        ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
        int uid,
        int width,
        int height,
        int elapsed,
        ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Group Calling'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    for (var uid in _users) {
      list.add(AgoraRenderWidget(uid));
    }
    return list;
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[_videoView(views[0])],
        );
      case 2:
        return Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        );
      case 3:
        return Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        );
      default:
    }
    return Container();
  }
}
