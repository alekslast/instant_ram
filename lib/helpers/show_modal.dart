import 'package:flutter/material.dart';

void showModal(BuildContext context, Widget modal) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext buildContext) => modal,
  );
}
