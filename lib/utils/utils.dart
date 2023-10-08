import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:fastowebrtc/utils/text.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

Uri? tryParseRaw(String uri) {
  try {
    return Uri.tryParse(uri);
  } on FormatException {
    return null;
  }
}

Uri? tryParseConnect(String uri) {
  try {
    final decoded = base64Decode(uri);
    final parsed = utf8.decode(decoded);
    return tryParseRaw(parsed);
  } on FormatException {
    return null;
  }
}

void openMailto(String contactEmailPath) {
  final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: contactEmailPath);
  launchUrl(_emailLaunchUri);
}

void openSameTab(String url) {
  window.open(url, '_self');
}

void openFullscreenMode() {
  document.documentElement?.requestFullscreen();
}

void closeFullscreenMode() {
  document.exitFullscreen();
}

void sendFormData(String name, String email) async {
  if (name.isEmpty || email.isEmpty) {
    _alert(errorEmptyText);
    return;
  }

  final Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
  };
  final body = json.encode({
    'email': email,
    'project': 'fastowebrtc',
    'text': sendMessageText.replaceAll('{}', name),
  });
  final url = Uri.parse('https://api.fastogt.com/api/landing');
  final response = http.post(url, headers: headers, body: body);
  response.then((value) {
    if (value.statusCode == 200) {
      _alert(alertText);
    } else {
      _alert('$errorMessageText');
    }
  });
}

void _alert(String message) {
  context.callMethod('alert', [message]);
}

