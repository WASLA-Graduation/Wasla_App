import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/resident_home_body.dart';

class ResidentHomeView extends StatefulWidget {
  const ResidentHomeView({super.key});

  @override
  State<ResidentHomeView> createState() => _ResidentHomeViewState();
}

class _ResidentHomeViewState extends State<ResidentHomeView> {

  @override
  void initState() {
    getResidentProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResidentHomeBody();
  }

  void getResidentProfile() async {
    await context.read<HomeResidentCubit>().getResidentProfile();
  
  }
}
