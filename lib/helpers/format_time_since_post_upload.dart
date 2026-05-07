import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

Widget formatTimeSincePostUpload(DateTime uploadTime) {
  final difference = DateTime.now().difference(uploadTime);

  final String formattedDate;

  if (difference.inDays > 7) {
    formattedDate = DateFormat('MMM dd, yyyy').format(uploadTime);
  } else if (difference.inDays >= 1) {
    final count = difference.inDays;
    formattedDate = count == 1 ? '1 day ago' : '$count days ago';
  } else if (difference.inHours >= 1) {
    final count = difference.inHours;
    formattedDate = count == 1 ? '1 hour ago' : '$count hours ago';
  } else if (difference.inMinutes >= 1) {
    final count = difference.inMinutes;
    formattedDate = count == 1 ? '1 minute ago' : '$count minutes ago';
  } else {
    formattedDate = 'jsut now';
  }

  return Text(
    formattedDate,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 165, 164, 164),
    ),
  );
}
