import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ColumnScroll extends StatefulWidget {
  const ColumnScroll({super.key});

  @override
  State<ColumnScroll> createState() => _ScrallableListState();
}

class _ScrallableListState extends State<ColumnScroll> {
  final itemKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        shape: CircleBorder(),
        onPressed: scrollToItem,
        child: Icon(Icons.arrow_downward, color: AppColors.primaryColor),
      ),
      appBar: AppBar(title: Text('Scrollable List')),

      body: SingleChildScrollView(
        child: Column(
          children: [
            buildItem(1),
            buildItem(2),
            buildItem(3),
            buildItem(4),
            buildItem(5),
            buildItem(6),
            buildItem(7),
            buildItem(8),
            buildItem(9),
            buildItem(10),
            buildItem(11),
            SizedBox(key: itemKey, child: buildItem(12)),
            buildItem(13),
            buildItem(14),
          ],
        ),
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

  void scrollToItem() {
    final itemContext = itemKey.currentContext!;
    Scrollable.ensureVisible(
      itemContext,
      alignment: 0.5,
      duration: Duration(seconds: 1),
    );
  }
}
