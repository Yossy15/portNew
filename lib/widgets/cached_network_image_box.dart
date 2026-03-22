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
    this.width,
    this.height,
    this.enableFullScreen = false, // 👈 เพิ่ม
    this.heroTag,
  });

  final String imageUrl;
  final double borderRadius;
  final double? width;
  final double? height;
  final bool enableFullScreen; // 👈 เพิ่ม
  final String? heroTag;

  void _openFullScreen(BuildContext context) {
    final tag = heroTag ?? imageUrl;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: _FullScreenImageView(
            imageUrl: imageUrl,
            heroTag: tag,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tag = heroTag ?? imageUrl;

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.grey[300],
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            highlightColor: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.4),
            child: Container(
              width: width,
              height: height,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image),
        ),
      ),
    );

    if (!enableFullScreen) return image; // 👈 ถ้า false คืน image เฉยๆ

    return GestureDetector(
      onTap: () => _openFullScreen(context),
      child: Hero(tag: tag, child: image),
    );
  }
}

class _FullScreenImageView extends StatelessWidget {
  const _FullScreenImageView({
    required this.imageUrl,
    required this.heroTag,
  });

  final String imageUrl;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: heroTag,
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[600]!,
                    child: Container(color: Colors.grey[800]),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}