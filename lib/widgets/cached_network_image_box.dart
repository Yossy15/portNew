import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

/// Shared image widget that wraps [CachedNetworkImage] and
/// provides unified loading + error UI.
class CachedNetworkImageBox extends StatelessWidget {
  const CachedNetworkImageBox({
    super.key,
    required this.imageUrl,
    this.borderRadius = 16,
    // this.aspectRatio = 16 / 9,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double borderRadius;
  // final double aspectRatio;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surfaceVariant,
          highlightColor:
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
          child: Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
      ),
    );
  }
}
