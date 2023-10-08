import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:fastowebrtc/utils/utils.dart';
import 'package:flutter/material.dart';

class Head extends StatelessWidget implements PreferredSizeWidget {
  final double width;
  final ScrollController scroll;

  const Head({super.key, required this.width, required this.scroll});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      height: width > 600 ? 70 : 100,
      child: width > 600
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: _buildTitle(18),
          ),
          if (width > 1000)
            const Expanded(
              flex: 8,
              child: SizedBox(),
            ),
          _buildButtons()
        ],
      )
          : Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: _buildTitle(24),
          ),
          _buildButtons()
        ],
      ),
    );
  }

  Widget _buildTitle(double fontSize) {
    return Center(
      child: InkWell(
        onTap: () {
          const time = const Duration(milliseconds: 1200);
          scroll.animateTo(0, duration: time, curve: Curves.ease);
        },
        child: Text(
          appTitleText,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Expanded(
      flex: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: Text(productsText),
            onTap: () => openSameTab(productsLinkText),
          ),
          InkWell(
            child: Text(pricingText),
            onTap: () => openSameTab(pricingLinkText),
          ),
          InkWell(
            child: Text(downloadsText),
            onTap: () => openSameTab(downloadsLinkText),
          ),
          ElevatedButton(
            onPressed: () =>
                openMailto(
                    contactUsEmailLinkText /* +
                '?subject=Cooperation with FastoCloud&body=Hi, I\'d like to set up FastoWebRTC player'*/
                ),
            child: Text(contactUsText),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 100);
}
