import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../features/authentication/data/data_sources/user_data_sources.dart' show UhlUsersDB;
import '../features/home/data/data_sources/feed_portal_data_sources.dart' show FeedDB;
import '../features/home/data/data_sources/notification_data_sources.dart' show NotificationsDB;
import '../features/home/data/data_sources/buy_sell_data_sources.dart' show BuySellDB;
import '../features/home/data/data_sources/job_portal_data_sources.dart' show JobPortalDB;
import '../features/home/data/data_sources/lost_found_data_sources.dart';
import '../features/authentication/domain/entities/user_entity.dart';

String getIdFromDriveLink(String url) {
  final RegExp regex =
      RegExp(r"https://drive\.google\.com/file/d/([^/]+)/view");
  final match = regex.firstMatch(url);
  if (match != null) {
    return match.group(1)!;
  } else {
    return "";
  }
}

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url.trim());
  log("$uri");
  try {
    await launchUrl(uri);
    log('Launched successfully');
  } catch (e) {
    log('Error occurred while launching: $e');
    throw 'Could not launch $url';
  }
}

Future<bool> checkUserLoggedIn() async {
  const storage = FlutterSecureStorage();

  final token = await storage.read(key: 'user');
  if (token != null) {
    return true;
  } else {
    return false;
  }
}

Future<UserEntity?> getUser() async {
  const storage = FlutterSecureStorage();

  final token = await storage.read(key: 'user');
  if (token != null) {
    return UserEntity.fromJson(jsonDecode(token));
  } else {
    return null;
  }
}

Future<void> connectToDB() async {
  await dotenv.load(fileName: "institute.env");
  await UhlUsersDB.connect(dotenv.env['DB_CONNECTION_URL']!);
  await JobPortalDB.connect(dotenv.env['DB_CONNECTION_URL']!);
  await LostFoundDB.connect(dotenv.env['DB_CONNECTION_URL']!);
  await BuySellDB.connect(dotenv.env['DB_CONNECTION_URL']!);
  await NotificationsDB.connect(dotenv.env['DB_CONNECTION_URL']!);
  await FeedDB.connect(dotenv.env['DB_CONNECTION_URL']!);
}