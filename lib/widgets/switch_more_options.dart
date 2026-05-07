import 'package:flutter/material.dart';

class SwitchMoreModal extends StatefulWidget {
  const SwitchMoreModal({super.key});

  @override
  State<SwitchMoreModal> createState() => _SwitchMoreModalState();
}

class _SwitchMoreModalState extends State<SwitchMoreModal> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) => setState(() => isSwitched = value),
    );
  }
}
