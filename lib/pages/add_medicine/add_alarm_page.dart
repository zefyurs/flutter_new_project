import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zef/pages/add_medicine/add_medicine_page.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage(
      {Key? key, required this.medicineImage, required this.medicineName})
      : super(key: key);

  final File? medicineImage;
  final String medicineName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: AddPageBody(
          children: [
            medicineName == null ? Container() : Image.file(medicineImage!),
            Text(medicineName),
          ],
        ));
  }
}
