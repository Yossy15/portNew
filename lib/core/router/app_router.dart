import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/login/login.dart';
import 'package:portfolio/features/other/widget/start_beb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/projects/presentation/projects_page.dart';
import '../../features/about/presentation/about_page.dart';
import '../../features/contact/presentation/contact_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/projects',
        name: 'projects',
        pageBuilder: (context, state) => const MaterialPage(
          child: ProjectsPage(),
        ),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        pageBuilder: (context, state) => const MaterialPage(
          child: AboutPage(),
        ),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        pageBuilder: (context, state) => const MaterialPage(
          child: ContactPage(),
        ),
      ),
      GoRoute(
        path: '/start-beb',
        name: 'start-beb',
        pageBuilder: (context, state) => const MaterialPage(
          child: StartBeb(),
        ),
      ),
      GoRoute(path:'/login', name: 'login', pageBuilder: (context, state) => const MaterialPage(child: Login())),
    ],
  );
}
