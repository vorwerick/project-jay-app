import 'package:url_launcher/url_launcher.dart';

final class MapUtils {
  MapUtils._();

  static Future<void> openMap(
      final double latitude, final double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    final Uri appleMapsUrl =
        Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw 'Could not launch url';
    }
  }

  static Future<void> openMapMapyCz(
      final double latitude, final double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    final Uri appleMapsUrl =
        Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');
    final Uri mapyCzUrl =
        Uri.parse('https://mapy.cz/zakladni?planovani-trasy&rs=coor&id=$longitude,$latitude&x=$longitude&y=$latitude&z=13');

    if (await canLaunchUrl(mapyCzUrl)) {
      await launchUrl(mapyCzUrl);
    } else if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw 'Could not launch url';
    }
  }
}
