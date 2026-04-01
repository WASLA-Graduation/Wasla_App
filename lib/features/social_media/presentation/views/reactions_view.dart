import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/social_media/presentation/widgets/reactions_view_body.dart';

class ReactionsView extends StatefulWidget {
  const ReactionsView({super.key, required this.postId});

  final int postId;

  @override
  State<ReactionsView> createState() => _ReactionsViewState();
}

class _ReactionsViewState extends State<ReactionsView> {
  @override
  void initState() {
    super.initState();
    getReactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("reactions".tr(context)),
      ),

      body: const ReactionsViewBody(),
    );
  }

  void getReactions() {}
}
