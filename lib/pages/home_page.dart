import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zef/components/dory_colors.dart';
import 'package:zef/pages/today/today_page.dart';

import 'add_medicine/add_medicine_page.dart';
import 'history/history_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pages = [const TodayPage(), const HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      // 상하단 여유 공간을 제외한 영역을 safeArea로 감싸줌 왜? 바깥에 색을 넣기 위해
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(),
          body: _pages[_currentIndex],
          floatingActionButton: FloatingActionButton(
              onPressed: _onAddMedicine, child: const Icon(CupertinoIcons.add)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _bulidBottomAppBar(),
        ),
      ),
    );
  }

  BottomAppBar _bulidBottomAppBar() {
    return BottomAppBar(
        elevation: 0,
        child: Container(
          height: kBottomNavigationBarHeight,
          color: Colors.grey[200],
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CupertinoButton(
                onPressed: () => _onCurrentPage(0),
                child: Icon(CupertinoIcons.check_mark,
                    color:
                        _currentIndex == 0 ? Colors.blue : Colors.grey[350])),
            CupertinoButton(
                onPressed: () => _onCurrentPage(1),
                child: Icon(CupertinoIcons.text_badge_checkmark,
                    color:
                        _currentIndex == 1 ? Colors.green : Colors.grey[350])),
          ]),
        ));
  }

  void _onAddMedicine() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (contxt) => const AddMedicinePage()),
    );
  }

  void _onCurrentPage(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }
}
