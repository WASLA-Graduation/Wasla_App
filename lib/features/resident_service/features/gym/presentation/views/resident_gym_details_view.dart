import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_details_body.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ResidentGymDetailsView extends StatefulWidget {
  const ResidentGymDetailsView({super.key, required this.details});
  final Map<String, dynamic> details;

  @override
  State<ResidentGymDetailsView> createState() => _ResidentGymDetailsViewState();
}

class _ResidentGymDetailsViewState extends State<ResidentGymDetailsView> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.details[AppStrings.gymName]),
        forceMaterialTransparency: true,
      ),
      body: const ResidentGymDetailsViewBody(),
    );
  }

  void callApi() {
    context.read<GymResidentCubit>().getGymDetails(
      gymId: widget.details[AppStrings.gymId],
    );
    context.read<GymResidentCubit>().selecedGymId =
        widget.details[AppStrings.gymId];
    context.read<ReviewsCubit>().resetState();
    context.read<ReviewsCubit>().getReveiws(widget.details[AppStrings.gymId]);
    context.read<ReviewsCubit>().selectedUserId =
        widget.details[AppStrings.gymId];
  }
}
