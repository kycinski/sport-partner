import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> openWebsite(String url) async {
    final uri = url.contains('http') ? Uri.parse(url) : Uri.parse('http://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }

  static Future<void> sendEmail(String emailAddress, String subject) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: 'subject=$subject',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
