import 'package:fastowebrtc/bloc/webrtc_receiver_bloc.dart';
import 'package:fastowebrtc/ui/pages/player_page.dart';
import 'package:fastowebrtc/ui/widgets/player.dart';
import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:fastowebrtc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerPanel extends StatefulWidget {
  final double width;

  const PlayerPanel({super.key, required this.width});

  @override
  State<PlayerPanel> createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel> {
  final TextEditingController _textarea = TextEditingController();

  static bool isLiveStreamOn = false;
  bool _mute = false;

  @override
  void initState() {
    super.initState();
    _textarea.text = exampleUrlText;
  }

  @override
  void dispose() {
    _textarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (widget.width > 1300) {
      width *= 0.52;
    } else if (widget.width > 1100) {
      width *= 0.62;
    } else if (widget.width > 900) {
      width *= 0.72;
    } else if (widget.width > 700) {
      width *= 0.82;
    } else {
      width *= 0.92;
    }
    return Column(
      children: [
        _buildLinkField(context, width),
        const SizedBox(height: 35),
        _buildPlayerScreen(context, width),
      ],
    );
  }

  Widget _buildLinkField(BuildContext context, double width) {
    final oIB = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    );
    return SizedBox(
      width: width,
      height: 40,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: _textarea,
        decoration: InputDecoration(
          isDense: true,
          hintText: enterUrlText,
          hintStyle: const TextStyle(color: hintTextColor),
          contentPadding: const EdgeInsets.only(left: 20),
          focusedBorder: oIB,
          enabledBorder: oIB,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: _elevatedButton(context),
        ),
      ),
    );
  }

  Widget _elevatedButton(BuildContext ctx) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(widget.width > 550 ? 120 : 70, 100),
        backgroundColor: buttonsColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: Text(playNowText),
      onPressed: () {
        if (_textarea.text.isNotEmpty) {
          ctx.read<PlaylistCubit>().setUrl(tryParseRaw(_textarea.text));
          isLiveStreamOn = true;
        } else {
          ctx.read<PlaylistCubit>().setUrl(null);
          isLiveStreamOn = false;
        }
        setState(() {});
      },
    );
  }

  Widget _buildPlayerScreen(BuildContext ctx, double width) {
    final player = Player(ctx.read<PlaylistCubit>().controller);
    return Container(
      width: width,
      height: width / 16 * 9,
      decoration: BoxDecoration(
        color: screenDefaultColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          if (isLiveStreamOn) player,
          Align(
            alignment: const Alignment(-0.9, -0.9),
            child: SvgPicture.asset('assets/images/live.svg'),
          ),
          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: StatefulBuilder(
              builder: (ctx, change) => InkWell(
                child: SvgPicture.asset(
                  _mute ? 'assets/images/volume_muted.svg' : 'assets/images/volume.svg',
                ),
                onTap: () {
                  if (!isLiveStreamOn) return;
                  ctx.read<PlaylistCubit>().controller.toggleMute();
                  change(() => _mute = !_mute);
                },
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.9, 0.9),
            child: StatefulBuilder(
              builder: (ctx, change) => InkWell(
                child: SvgPicture.asset('assets/images/full_mode.svg'),
                onTap: () async {
                  if (!isLiveStreamOn) return;
                  final route = MaterialPageRoute(builder: (_) {
                    return PlayerPage(player: player, mute: _mute);
                  });
                  _mute = await Navigator.push(ctx, route);
                  change(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
