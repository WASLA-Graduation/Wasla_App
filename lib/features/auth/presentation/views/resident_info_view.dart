import 'package:flutter/material.dart';
import 'package:wasla/features/auth/presentation/widgets/resident_view_body.dart';

class ResidentInfoView extends StatelessWidget {
  const ResidentInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Fill Your Profile"),
      ),
      body: ResidentViewBody(),
    );
  }
}
