import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';

class MySocialMediaIcons extends StatelessWidget {
  const MySocialMediaIcons({super.key});

  Future<void> _launchURL(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  Widget buildIcon(IconData icon, Uri url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        color: AppColors.blue,
        size: 35,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(children: [
        buildIcon(
          FontAwesomeIcons.facebook,
          Uri.parse('https://web.facebook.com/mazenshawky0'),
        ),
        const SizedBox(width: 15),
        buildIcon(
          FontAwesomeIcons.youtube,
          Uri.parse('https://www.youtube.com/@mazenshawky'),
        ),
        const SizedBox(width: 15),
        buildIcon(
          FontAwesomeIcons.telegram,
          Uri.parse('https://t.me/mazenshawky'),
        ),
      ]),
    );
  }
}
