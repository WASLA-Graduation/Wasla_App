import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/gym_resident_body.dart';

class GymResidentView extends StatefulWidget {
  const GymResidentView({super.key});

  @override
  State<GymResidentView> createState() => _GymResidentViewState();
}

class _GymResidentViewState extends State<GymResidentView> {
  @override
  void initState() {
    getAllGyms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("gyms".tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: GymResidentViewBody(),
      ),
    );
  }

  void getAllGyms() async {
    context.read<FavouriteCubit>().getFavouritesByType(serviceType: 4);
    context.read<GymResidentCubit>().reset();
    context.read<GymResidentCubit>().getAllGyms(fromPagination: false);
  }
}
