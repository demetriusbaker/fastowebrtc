import 'package:fastowebrtc/bloc/webrtc_receiver_bloc.dart';
import 'package:fastowebrtc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerPage extends StatefulWidget {
  final Widget player;
  final bool mute;

  const PlayerPage({super.key, required this.player, required this.mute});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _mute = false;

  @override
  void initState() {
    super.initState();
    _mute = widget.mute;
    openFullscreenMode();
  }

  @override
  void dispose() {
    super.dispose();
    closeFullscreenMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: widget.player),
          Align(
            alignment: const Alignment(-0.9, -0.9),
            child: SvgPicture.asset('assets/images/live.svg'),
          ),
          StatefulBuilder(
            builder: (ctx, change) =>
                Align(
                  alignment: const Alignment(-0.9, 0.9),
                  child: InkWell(
                    child: SvgPicture.asset(
                        _mute ? 'assets/images/volume_muted.svg' : 'assets/images/volume.svg'),
                    onTap: () {
                      context
                          .read<PlaylistCubit>()
                          .controller
                          .toggleMute();
                      change(() => _mute = !_mute);
                    },
                  ),
                ),
          ),
          Align(
            alignment: const Alignment(0.9, 0.9),
            child: InkWell(
              child: SvgPicture.asset('assets/images/full_mode_out.svg'),
              onTap: () {
                Navigator.pop(context, _mute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
