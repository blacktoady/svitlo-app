import 'package:url_launcher/url_launcher.dart';

Future<void> launchLink(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}