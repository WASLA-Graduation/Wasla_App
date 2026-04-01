import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  const AnimationTest({super.key});

  @override
  State<AnimationTest> createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  final int listSize = 35;
  final Set<int> visibleIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animation Test")),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: listSize,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return _AnimatedItem(
            index: index,
            visibleIndices: visibleIndices,
          );
        },
      ),
    );
  }
}

class _AnimatedItem extends StatefulWidget {
  final int index;
  final Set<int> visibleIndices;

  const _AnimatedItem({required this.index, required this.visibleIndices});

  @override
  State<_AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<_AnimatedItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    if (widget.visibleIndices.contains(widget.index)) {
      _visible = true;
      return;
    }

    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        setState(() {
          _visible = true;
          widget.visibleIndices.add(widget.index);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0, end: _visible ? 1 : 0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(100 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Text(
        "Item ${widget.index}",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}