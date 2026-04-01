import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';

class ReactionsViewBody extends StatelessWidget {
  const ReactionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage(Assets.assetsImagesProfile),
        ),
        title: Text("user $index"),
        subtitle: Text("comment $index"),
      ),
    );
  }
}
