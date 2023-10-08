import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:fastowebrtc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Foot extends StatelessWidget {
  final double width;
  final ScrollController scroll;

  const Foot({super.key, required this.width, required this.scroll});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomBarColor,
      height: 200,
      child: width > 1000
          ? longPanel()
          : width > 700
          ? _mediumPanel()
          : _shortPanel(),
    );
  }

  Widget longPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: width > 1200 ? 4 : 3,
          child: _buildTitle(),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildButtons(),
          ),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSocialMediaButtons(),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _mediumPanel() {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: _buildTitle(),
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildButtons(),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildSocialMediaButtons(),
                  ),
                ),
              ),
              const SizedBox(width: 35),
            ],
          ),
        )
      ],
    );
  }

  Widget _shortPanel() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _buildTitle(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildButtons(),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSocialMediaButtons(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSocialMediaButtons() {
    return [
      _buildSocialMediaButton('assets/images/linkedin.svg', linkedinLinkText),
      _buildSocialMediaButton('assets/images/discord.svg', discordLinkText),
      _buildSocialMediaButton('assets/images/facebook.svg', facebookLinkText),
      _buildSocialMediaButton('assets/images/gitlab.svg', gitlabLinkText),
      _buildSocialMediaButton('assets/images/github.svg', githubLinkText),
    ];
  }

  List<Widget> _buildButtons() {
    return [
      _buildInkWell(productsText, () => openSameTab(productsLinkText)),
      _buildInkWell(pricingText, () => openSameTab(pricingLinkText)),
      _buildInkWell(downloadsText, () => openSameTab(downloadsLinkText)),
    ];
  }

  Widget _buildTitle() {
    return Center(
      child: InkWell(
        onTap: () {
          const time = const Duration(milliseconds: 1200);
          scroll.animateTo(0, duration: time, curve: Curves.ease);
        },
        child: Text(
          appTitleText,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInkWell(String text, [void Function()? onTap]) {
    const style = TextStyle(color: subFeatTextColor, fontSize: 17.5);
    return InkWell(
      onTap: onTap,
      child: Text(text, style: style),
    );
  }

  Widget _buildSocialMediaButton(String assets, String url) {
    return InkWell(
        child: SvgPicture.asset(assets),
        onTap: () {
          openSameTab(url);
        });
  }
}
