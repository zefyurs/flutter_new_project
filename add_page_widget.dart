import 'package:flutter/material.dart';
import 'package:zef/components/dory_constants.dart';

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
      child: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class BottomSubmitButton extends StatelessWidget {
  const BottomSubmitButton(
      {super.key, required this.onPressed, required this.text});
  //style 버튼을 빼면서 onPressed 부문을 활용해주기 위함
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: submitButtonBoxPadding,
        child: SizedBox(
          height: submitButtonHeight,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.subtitle1),
              child: Text(text)),
        ),
      ),
    );
  }
}
