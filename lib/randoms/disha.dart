import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Disha extends StatefulWidget {
  const Disha({super.key});

  @override
  State<Disha> createState() => _DishaState();
}

class _DishaState extends State<Disha> with SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int? highlightedIndex;
  late AnimationController animationController;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    );
    colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.grey.withOpacity(0.15),
    ).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(20);
    });
  }

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      alignment: 0.5,

      curve: Curves.easeInOut,
    );

    setState(() {
      highlightedIndex = index;
      animationController.repeat(reverse: true, count: 5).then((val) {
        setState(() {
          highlightedIndex = null;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disha')),
      body: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: 30,
        itemBuilder: (context, index) {
          bool isHighlighted = index == highlightedIndex;
          return AnimatedBuilder(
            animation: colorAnimation,
            builder: (context, child) => Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              padding: const EdgeInsets.all(12),
              color: isHighlighted ? colorAnimation.value : Colors.white,

              child: ListTile(title: Text('Item $index')),
            ),
          );
        },
      ),
    );
  }
}
