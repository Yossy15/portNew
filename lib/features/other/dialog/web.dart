import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/features/other/widget/web_url.dart';
import 'package:portfolio/responsive/screen_size_provider.dart';
import 'package:shimmer/shimmer.dart';

class WebGridDialog extends HookConsumerWidget {
  const WebGridDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const WebGridDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = ref.watch(screenSizeProvider);
    final wedImages = [
      'https://lh3.googleusercontent.com/d/1t4a9O6NjKTkuAkfwYixDExSHcuEJC9ek',
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pictures',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Grid
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenSize.isDesktop ? 5 : 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: wedImages.length,
                itemBuilder: (context, index) {
                  return _WebGridItem(imageUrl: wedImages[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebGridItem extends StatefulWidget {
  const _WebGridItem({required this.imageUrl});

  final String imageUrl;

  @override
  State<_WebGridItem> createState() => _WebGridItemState();
}

class _WebGridItemState extends State<_WebGridItem> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openweburl('https://yossy15.github.io/surprise/');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            WebUrl(
              imageUrl: widget.imageUrl,
              onTap: () {
                openweburl('https://yossy15.github.io/surprise/');
              },
            ),
            if (_isLoading)
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
