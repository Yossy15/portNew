import 'package:flutter/material.dart';
import 'package:portfolio/widgets/cached_network_image_box.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openweburl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class WebUrl extends StatelessWidget {
  const WebUrl({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImageBox(
            imageUrl: imageUrl,
            borderRadius: 8,
          ),
          // overlay hint
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              color: Colors.black45,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.open_in_new, color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'เปิดเว็บ',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}