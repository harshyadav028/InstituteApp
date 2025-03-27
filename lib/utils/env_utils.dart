import 'package:flutter_dotenv/flutter_dotenv.dart';

List<String> getAdminEmails() {
  String adminEmailsString = dotenv.env["POR_EMAILS"] ?? "";
  if (adminEmailsString.isEmpty) {
    return [];
  }
  return adminEmailsString.split(',').map((email) => email.trim()).toList();
}

bool isAdmin(String email) {
  return getAdminEmails().contains(email);
}
