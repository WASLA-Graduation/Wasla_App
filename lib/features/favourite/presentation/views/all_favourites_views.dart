import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/favourite/presentation/widgets/all_favourites_view_body.dart';

class AllFavouritesViews extends StatefulWidget {
  const AllFavouritesViews({super.key});

  @override
  State<AllFavouritesViews> createState() => _AllFavouritesViewsState();
}

class _AllFavouritesViewsState extends State<AllFavouritesViews> {
  @override
  void initState() {
    getAllFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("myFavourites".tr(context))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: const AllFavouritesViewBody(),
      ),
    );
  }

  void getAllFavourites() async {
    await context.read<FavouriteCubit>().getAllFavourites();
  }
}
