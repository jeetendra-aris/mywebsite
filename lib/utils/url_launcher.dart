import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

void urlLauncher({required String url}) async {
  try {
    String finalUrl = url.trim();
    if (finalUrl.isEmpty) {
      debugPrint('URL is empty');
      return;
    } else {
      // Add scheme if missing
      if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
        finalUrl = 'https://$finalUrl';
      }

      // Parse URI safely
      final Uri uri = Uri.tryParse(finalUrl) ?? Uri();

      if (!uri.hasScheme) {
        debugPrint('Invalid URL: $finalUrl');
        return;
      }

      // Check if device can launch
      if (!await canLaunchUrl(uri)) {
        debugPrint('Cannot launch URL: $finalUrl');
        return;
      }

      if (Platform.isIOS || Platform.isAndroid) {
        await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      } else {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  } catch (e, stackTrace) {
    debugPrint('Error launching URL: $e');
    debugPrint('$stackTrace');
  }
}
