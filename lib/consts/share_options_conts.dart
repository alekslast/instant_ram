import 'package:flutter/material.dart';
import 'package:instant_ram/models/share_option_model.dart';

final List<ShareOptionModel> shareOptionsConst = [
  ShareOptionModel(
    title: "Share",
    icon: Icons.share_outlined,
    bgColor: const Color.fromARGB(255, 77, 77, 77),
  ),
  ShareOptionModel(
    title: "WhatsApp",
    icon: Icons.add_call,
    bgColor: const Color.fromARGB(255, 80, 219, 91),
  ),
  ShareOptionModel(
    title: "Copy Link",
    icon: Icons.link,
    bgColor: const Color.fromARGB(255, 77, 77, 77),
  ),
  ShareOptionModel(
    title: "Add story",
    icon: Icons.auto_mode_rounded,
    bgColor: const Color.fromARGB(255, 77, 77, 77),
  ),
  ShareOptionModel(
    title: "SMS",
    icon: Icons.message_outlined,
    bgColor: const Color.fromARGB(255, 61, 134, 243),
  ),
  ShareOptionModel(
    title: "Dowload",
    icon: Icons.file_download_outlined,
    bgColor: const Color.fromARGB(255, 77, 77, 77),
  ),
  ShareOptionModel(
    title: "Threds",
    icon: Icons.alternate_email_rounded,
    bgColor: const Color.fromARGB(255, 0, 0, 0),
  ),
];
