import 'package:flutter/material.dart';
import 'package:flutter_webrtc_sdk/flutter_webrtc_sdk.dart';

class Player extends StatelessWidget {
  final WebRTCPlayerBloc controller;

  const Player(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWebRTCPlayer(
      controller: controller,
      playerBuilder: (_, __, player) => SizedBox.expand(child: player),
      placeholder: Container(),
    );
  }
}
