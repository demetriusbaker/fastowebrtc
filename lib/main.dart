import 'package:fastowebrtc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/webrtc_receiver_bloc.dart';
import 'ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

const String appName = "FastoWebRTC";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: buttonsColor, // background color
            ),
          ),
          brightness: Brightness.dark,
          fontFamily: 'Roboto',
        ).copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: HomePage(),
      ),
    );
  }
}
