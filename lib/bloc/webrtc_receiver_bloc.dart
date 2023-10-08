import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc_sdk/flutter_webrtc_sdk.dart';

class PlayerIdState {
  final Uri? url;

  const PlayerIdState(this.url);
}

class PlayerInitState extends PlayerIdState {
  const PlayerInitState() : super(null);
}

class PlayerLoadingState extends PlayerIdState {
  const PlayerLoadingState(Uri url) : super(url);
}

class ConnectionInfo {
  final String originalUrl;

  ConnectionInfo(this.originalUrl);

  String get socketUrl => _generateUrlWithProtocol('ws', 'wss');

  String get restApiUrl => _generateUrlWithProtocol('http', 'https');

  String _generateUrlWithProtocol(String unsecure, String secure) {
    final uri = Uri.parse(originalUrl);
    var host = uri.host;

    if (uri.hasPort) {
      host += ':${uri.port}';
    }

    final useSecureProtocols =
        uri.isScheme('https') || uri.isScheme('wss') || uri.isScheme('webrtcs');

    return '${useSecureProtocols ? secure : unsecure}://$host';
  }
}

class PlaylistCubit extends Cubit<PlayerIdState> {
  final controller = PlaylistRTCPlayerController();

  PlaylistCubit() : super(const PlayerInitState());

  void setUrl(Uri? url) async {
    if (url == null) {
      emit(const PlayerInitState());
      controller.bye();
      return;
    }

    emit(PlayerLoadingState(url));

    final info = ConnectionInfo(url.toString());
    final wshost = info.socketUrl;
    final id = url.pathSegments.where((e) => e.isNotEmpty).join('/');
    controller.connect(wshost, id);

    await controller.stream.firstWhere((e) => e == WebRTCPlayerState.playing);
    emit(PlayerIdState(url));
  }

  @override
  Future<void> close() async {
    controller.dispose();
    super.close();
  }
}
