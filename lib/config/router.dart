// import 'package:silesra/models/itemDetails.dart';
import 'package:silesra/models/product_model.dart';
import 'package:silesra/pages/Add_property.dart';
import 'package:silesra/pages/HomePage.dart';
import 'package:silesra/pages/adding_accessories.dart';
import 'package:silesra/pages/adding_car.dart';
import 'package:silesra/pages/adding_electronics.dart';
import 'package:silesra/pages/adding_fashion.dart';
import 'package:silesra/pages/adding_house.dart';
import 'package:silesra/pages/adding_other.dart';
import 'package:silesra/pages/adding_services.dart';
import 'package:silesra/pages/auth.dart';
import 'package:silesra/pages/detail_page.dart';
import 'package:silesra/pages/notification.dart';
import 'package:silesra/pages/onboarding.dart';
import 'package:silesra/pages/postedproperties.dart';
import 'package:silesra/pages/profile.dart';
import 'package:silesra/pages/resetand%20forgotpassword.dart';
import 'package:silesra/pages/splash.dart';
import 'package:silesra/pages/transactiondetail.dart';
import 'package:silesra/pages/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Dataprovider/Models.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
        path: '/forgetresset',
        builder: (context, state) {
          final isResetMode = state.extra != null &&
              (state.extra as Map)['isResetMode'] == true;
          return ForgetResetPasswordPage(isResetMode: isResetMode);
        }),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: '/transactionhistory',
      builder: (context, state) => const TransactionHistoryPage(),
    ),
    GoRoute(
      path: '/postedproperties',
      builder: (context, state) => const PostedPropertiesPage(),
    ),
    GoRoute(
      path: '/watchlist',
      builder: (context, state) => const WatchlistPage(),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final item = state.extra as BaseListing?;
        if (item == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('No product details available.')),
          );
        }
        return DetailsPage(item: item);
      },
    ),
    GoRoute(
      path: '/addproperty',
      builder: (context, state) => const AddPropertyPage(),
    ),
    GoRoute(
      path: '/addhouseproperty',
      builder: (context, state) => const AddingHousePages(),
    ),
    GoRoute(
      path: '/addcarproperty',
      builder: (context, state) => const AddingCarPage(),
    ),
    GoRoute(
      path: '/addaccessoryproperty',
      builder: (context, state) => const AddingAccessoryPage(),
    ),
    GoRoute(
      path: '/addfashionproperty',
      builder: (context, state) => const AddingFashionPage(),
    ),
    GoRoute(
      path: '/addelectronicsproperty',
      builder: (context, state) => const AddingElectronicsPage(),
    ),
    GoRoute(
      path: '/addservices',
      builder: (context, state) => const AddingServicePage(),
    ),
    GoRoute(
      path: '/addotherservices',
      builder: (context, state) => const OtherServicePage(),
    ),
  ],
);
