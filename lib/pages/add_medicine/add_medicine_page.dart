import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zef/components/dory_constants.dart';
import 'package:zef/components/dory_page_route.dart';
import 'package:zef/pages/add_medicine/add_alarm_page.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  // * Textformfield 의 경우 Statefulwidget로 변경후 함수 선언해줘야함
  final _nameController = TextEditingController();
  File? _medicineImage;
  // Image pircker 를 위한 변수 지정 nunable 값으로 -> 처음에는 파일이 없으므로

  @override
  // * text editing controller는 dispose할때 reset 해줘야함
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: AddPageBody(
        children: [
          //여백
          const SizedBox(height: largeSpace),
          Text('어떤 약이예요?', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: largeSpace),
          // 사진 icon
          Center(
            child: MedicineImageButton(
              changeImageFile: (File? value) {
                _medicineImage = value;
              },
            ),
          ),
          const SizedBox(height: largeSpace + regularSpace),
          // 약이름
          Text('약 이름', style: Theme.of(context).textTheme.subtitle1),
          TextFormField(
            controller: _nameController,
            maxLength: 20,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
                hintText: '복용할 약 이름을 기입해주세요',
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding: textFieldContentPadding),
            onChanged: (_) {
              setState(() {});
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: _nameController.text.isEmpty ? null : _onAddAlarmPage,
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.subtitle1),
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddAlarmPage() {
    Navigator.push(
        context,
        FadePageRoute(
            page: AddAlarmPage(
          medicineImage: _medicineImage,
          medicineName: _nameController.text,
          // 기존 코드 페이지 전환 효과(fade)를 넣기 위해 위와 같이 변경
          // MaterialPageRoute(
          //     builder: (context) => AddAlarmPage(
          // medicineImage: _medicineImage,
          // medicineName: _nameController.text,
        )));
  }
}

// body의 초기 세팅값을 위젯으로 빼기 ch03_01 두번째 추가창, 단순 ui 제작
class AddPageBody extends StatelessWidget {
  const AddPageBody({super.key, required this.children});

// children을 받아주기 위해 추가
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 탭하기 전에 키보드 자동으로 안뜨게 함
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({super.key, required this.changeImageFile});

  final ValueChanged<File?> changeImageFile;
  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}

class _MedicineImageButtonState extends State<MedicineImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _pickedImage == null ? null : EdgeInsets.zero,
        onPressed: _showBottomSheet,
        child: _pickedImage == null
            ? const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30,
                color: Colors.white,
              )
            : CircleAvatar(
                foregroundImage: FileImage(_pickedImage!),
                radius: 40,
              ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return PickImageBottomSheet(
            onPressedCamera: () => _onPressed(ImageSource.camera),
            onPressedGalary: () => _onPressed(ImageSource.gallery),
          );
        });
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xfile) {
      if (xfile != null) {
        setState(() {
          _pickedImage = File(xfile.path);
          widget.changeImageFile(_pickedImage);
        });
      }
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet(
      {super.key,
      required this.onPressedCamera,
      required this.onPressedGalary});

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGalary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextButton(
            onPressed: onPressedCamera,
            child: Text(
              '카메라로 촬영',
              style: Theme.of(context).textTheme.button,
            )),
        TextButton(
            onPressed: onPressedGalary,
            child: Text(
              '앨범에서 가져오기 ',
              style: Theme.of(context).textTheme.button,
            )),
      ]),
    );
  }
}
