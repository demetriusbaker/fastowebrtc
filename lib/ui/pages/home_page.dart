import 'package:fastowebrtc/ui/widgets/features_table.dart';
import 'package:fastowebrtc/ui/widgets/foot.dart';
import 'package:fastowebrtc/ui/widgets/head.dart';
import 'package:fastowebrtc/ui/widgets/lets_talk_form.dart';
import 'package:fastowebrtc/ui/widgets/player_panel.dart';
import 'package:fastowebrtc/ui/widgets/titles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, size) {
        final width = size.maxWidth;
        return Scaffold(
          appBar: Head(width: width, scroll: scroll),
          body: SingleChildScrollView(
            controller: scroll,
            child: Container(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Titles(width: width),
                  const SizedBox(height: 30),
                  PlayerPanel(width: width),
                  const SizedBox(height: 160),
                  LetsTalkForm(width: width),
                  const SizedBox(height: 170),
                  FeatureTable(width: width),
                  const SizedBox(height: 190),
                  Foot(width: width, scroll: scroll),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
