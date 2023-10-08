import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureTable extends StatelessWidget {
  final double width;

  const FeatureTable({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    final isComputerFormat = width > 1050;
    final featuresList = <Widget>[
      _createFeatureCard(
        asset: 'assets/images/image.svg',
        title: 'Low Latency Adaptive Streaming',
        description:
            'Deliver your livestreams to a global audience with minimal delay,\nensuring quality and real-time experience for your viewers worldwide.',
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image2.svg',
        title: 'Customization Made Easy',
        description:
            'Easily integrate our WebRTC player into your projects with open-\nsource SDK, ensuring smooth customization and implementation.',
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image3.svg',
        title: 'Cross-Platform Compatibility',
        description:
            'FastoWebRTC is compatible and available on a wide range of\nplatforms, including Android, iOS, Web, MacOS, Windows, Linux,\nEmbedded, and Fuchsia, ensuring broad access for your audience.',
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image4.svg',
        title: 'Real-Time Analytics',
        description:
            "Gain valuable insights into your livestream's performance. Monitor\nviewer numbers, peak viewing time, average start-up time, and\nbandwidth data usage over time.",
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image5.svg',
        title: 'Access Control',
        description:
            'Take full control of who can access your livestreams. Protect your\ncontent from unauthorized hosting or limit access to specific\nlocations.',
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image6.svg',
        title: 'Live-to-ANY Transition',
        description:
            'Automatically record and export your live content as downloadable\nvideos, enabling you to restream it to any cloud or platform\nseamlessly.',
        isComputerFormat: isComputerFormat,
      ),
      _createFeatureCard(
        asset: 'assets/images/image7.svg',
        title: 'Powered by FastoCloud',
        description: 'Benefit from all the robust features of FastoCloud PRO media\nservices.',
        isComputerFormat: isComputerFormat,
      ),
    ];
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              featuresText,
              style: TextStyle(
                fontSize: isComputerFormat ? 56 : 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children:
                  isComputerFormat ? _childrenTable(featuresList) : _childrenColumn(featuresList),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _childrenTable(List<Widget> featuresList) {
    return [
      for (int i = 0; i < featuresList.length / 2 + 1; i += 2)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: featuresList[i]),
            const SizedBox(),
            Expanded(child: featuresList[i + 1]),
          ],
        ),
      if (featuresList.length % 2 != 0) featuresList[featuresList.length - 1]
    ];
  }

  List<Widget> _childrenColumn(List<Widget> featuresList) {
    return [for (var feat in featuresList) feat];
  }

  Widget _createFeatureCard({
    required String asset,
    required String title,
    required String description,
    bool isComputerFormat = true,
  }) {
    final double size1, size2, size;
    if (isComputerFormat) {
      if (width > 1500) {
        size1 = 36;
        size2 = 17.5;
        size = 73.0;
      } else if (width > 1400) {
        size1 = 32;
        size2 = 16;
        size = 71.0;
      } else if (width > 1275) {
        size1 = 28;
        size2 = 14.5;
        size = 69.0;
      } else if (width > 1150) {
        size1 = 24;
        size2 = 13;
        size = 67.0;
      } else {
        size1 = 20;
        size2 = 11.5;
        size = 65.0;
      }
    } else {
      if (width > 700) {
        size1 = 32;
        size2 = 16;
        size = 71.0;
      } else if (width > 645) {
        size1 = 28;
        size2 = 14.5;
        size = 69.0;
      } else if (width > 580) {
        size1 = 24;
        size2 = 13;
        size = 67.0;
      } else if (width > 525) {
        size1 = 20;
        size2 = 11.5;
        size = 65.0;
      } else if (width > 470) {
        size1 = 16;
        size2 = 10;
        size = 61.0;
      } else {
        size1 = 12;
        size2 = 8.5;
        size = 57.0;
      }
    }
    final style = TextStyle(fontSize: size1);
    final style2 = TextStyle(color: subTextColor, fontSize: size2);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: featureIconBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: SvgPicture.asset(asset),
          ),
          SizedBox(width: width > 525 ? 35 : 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: style),
              const SizedBox(height: 10),
              Text(description, style: style2),
            ],
          ),
        ],
      ),
    );
  }
}
