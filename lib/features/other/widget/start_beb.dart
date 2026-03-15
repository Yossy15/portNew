import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/other/widget/icon_beb.dart';

class StartBeb extends ConsumerWidget {
  const StartBeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: theme.colorScheme.primary,
          // alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    width: 1,
                  ),
                ),
                child: IconButton(
                    onPressed: () {
                      context.go('/');
                    },
                    icon: Icon(Icons.arrow_back_ios,
                        color: theme.colorScheme.onPrimary, size: 24)),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('ฝากบอก YOSS'),
                              content: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    const Text(
                                        'Baby อยากบอกอะไร Yossy ไหมมมม??'),
                                    Gap(12),
                                    TextField(
                                      controller: TextEditingController(),
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: 'บอกมาเลยสิจ๊ะะ',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    }
                                  },
                                  child: const Text('ยกเลิก'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    }
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('แจ้งเตือน'),
                                          content: const Text(
                                              'ยังส่งไม่ได้จ้าาาาาา!!!!!!!!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                if (context.canPop()) {
                                                  context.pop();
                                                }
                                              },
                                              child: const Text('ตกลง'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('ตกลง'),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.onSecondary,
                      foregroundColor: theme.colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "ฝากบอก YOSS",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
          // Text("ผลงาน เบบี๋ ❤️",
          //     style: theme.textTheme.titleLarge?.copyWith(
          //       color: theme.colorScheme.onSecondary,
          //       fontWeight: FontWeight.bold,
          //     )),
        ),
        Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Column(
              children: [
                IconBeb(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('แจ้งเตือน'),
                          content:
                              const Text('ยังไม่ให้เข้สดูหรอกจ้าาาาาา!!!!!!!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ยกเลิก'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    },
                    textlabel: "Picture"),
              ],
            ),
            Column(
              children: [
                IconBeb(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('แจ้งเตือน'),
                          content:
                              const Text('ยังไม่ให้เข้สดูหรอกจ้าาาาาา!!!!!!!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ยกเลิก'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    },
                    textlabel: "Video"),
              ],
            ),
            Column(
              children: [
                IconBeb(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('แจ้งเตือน'),
                          content:
                              const Text('ยังไม่ให้เข้สดูหรอกจ้าาาาาา!!!!!!!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ยกเลิก'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('ตกลง'),
                            ),
                          ],
                        ),
                      );
                    },
                    textlabel: "Web"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
