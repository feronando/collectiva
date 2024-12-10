import 'package:collectiva/pages/add_new_event_page.dart';
import 'package:collectiva/pages/add_new_item_page.dart';
import 'package:collectiva/pages/event_details_page.dart';
import 'package:collectiva/pages/item_details_page.dart';
import 'package:collectiva/pages/login_page.dart';
import 'package:collectiva/pages/signup_page.dart';
import 'package:collectiva/pages/tabs.dart';
import 'package:collectiva/providers/event_provider.dart';
import 'package:collectiva/providers/resource_provider.dart';
import 'package:collectiva/providers/user_provider.dart';
import 'package:collectiva/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EventProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ResourceProvider()),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CollectivaRoutes.LOGIN,
      routes: {
        CollectivaRoutes.LOGIN : (ctx) => const LoginPage(),
        CollectivaRoutes.NEW_USER : (ctx) => const SignupPage(),
        CollectivaRoutes.TABS : (ctx) => const TabsController(),
        CollectivaRoutes.NEW_ITEM : (ctx) => const AddNewItemPage(),
        CollectivaRoutes.NEW_EVENT : (ctx) => const AddNewEventPage(),
        CollectivaRoutes.EVENT_DETAILS : (ctx) => const EventDetailsPage(),
        CollectivaRoutes.ITEM_DETAILS : (ctx) => ItemDetailsPage(),
      },
    );
  }
}