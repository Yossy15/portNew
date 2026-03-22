import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/gen/assets.gen.dart';
import 'package:portfolio/responsive/screen_size_provider.dart';
import 'package:video_player/video_player.dart';

class VideoGridDialog extends HookConsumerWidget {
  const VideoGridDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const VideoGridDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = ref.watch(screenSizeProvider);

    final videos = Assets.videos.values;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Videos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenSize.isDesktop ? 5 : 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return _VideoThumbnailItem(
                    assetPath: videos[index],
                    onTap: () => _VideoPlayerDialog.show(
                      context,
                      videos[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoThumbnailItem extends HookWidget {
  const _VideoThumbnailItem({
    required this.assetPath,
    required this.onTap,
  });

  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => VideoPlayerController.asset(assetPath),
    );
    final isInitialized = useState(false);

    useEffect(() {
      controller.initialize().then((_) {
        isInitialized.value = true;
      });
      return controller.dispose;
    }, [controller]);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            isInitialized.value
                ? VideoPlayer(controller)
                : Container(color: Colors.grey[300]),
            Container(
              color: Colors.black38,
              child: const Center(
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoPlayerDialog extends StatelessWidget {
  const _VideoPlayerDialog({required this.assetPath});

  final String assetPath;

  static void show(BuildContext context, String assetPath) {
    showDialog(
      context: context,
      builder: (_) => _VideoPlayerDialog(assetPath: assetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            _ChewiePlayer(assetPath: assetPath),
            Positioned(
              top: 8,
              right: 8,
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
          ],
        ),
      ),
    );
  }
}

class _ChewiePlayer extends HookWidget {
  const _ChewiePlayer({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final videoController = useMemoized(
      () => VideoPlayerController.asset(assetPath),
    );
    final chewieController = useState<ChewieController?>(null);
    final isInitialized = useState(false);

    useEffect(() {
      videoController.initialize().then((_) {
        chewieController.value = ChewieController(
          videoPlayerController: videoController,
          autoPlay: true,
          looping: false,
          aspectRatio: videoController.value.aspectRatio,
        );
        isInitialized.value = true;
      });
      return () {
        chewieController.value?.dispose();
        videoController.dispose();
      };
    }, [videoController]);

    if (!isInitialized.value) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: Chewie(controller: chewieController.value!),
    );
  }
}