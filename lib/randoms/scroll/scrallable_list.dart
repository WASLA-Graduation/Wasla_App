import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ScrallableList extends StatefulWidget {
  const ScrallableList({super.key});

  @override
  State<ScrallableList> createState() => _ScrallableListState();
}

class _ScrallableListState extends State<ScrallableList> {
  final itemScrollController = ItemScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      scrollToIndex(13);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        shape: CircleBorder(),
        onPressed: () {
          scrollToIndex(13);
        },
        child: Icon(Icons.arrow_downward, color: AppColors.primaryColor),
      ),
      appBar: AppBar(title: Text('Scrollable List')),

      body: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,

        itemCount: 20,
        itemBuilder: (context, index) => buildItem(index + 1),
      ),
    );
  }

  Widget buildItem(int index) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      color: AppColors.primaryColor,
      child: Center(
        child: Text(
          "Item $index",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      alignment: 0.5,
      curve: Curves.easeInOut,
    );
  }




  
}
