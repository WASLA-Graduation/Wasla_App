import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/custom_home_app_bar.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/driver/features/home/presentation/widgets/get_driver_statisitcs.dart';

class DirverDahsboardBody extends StatelessWidget {
  const DirverDahsboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocBuilder<DriverCubit, DriverState>(
            buildWhen: (previous, current) =>
                current is DriverGetProfileSuccess ||
                current is DriverGetProfileLoading,
            builder: (context, state) {
              final cubit = context.read<DriverCubit>();
              return CustomHomeAppBar(
                isLoading: cubit.user == null,
                userName: cubit.user?.fullName,
                imageUrl: cubit.user?.imageUrlBase,
                onBookmarkTap: () {},
                showBookmark: false,
              );
            },
          ),
        ),
        SliverToBoxAdapter(child: const SizedBox(height: 20)),
        const GetDriverStatisitcs(),
      ],
    );
  }
}
