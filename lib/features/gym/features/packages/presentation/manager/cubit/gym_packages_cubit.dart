import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/gym/features/packages/data/repo/gym_packages_repo.dart';

part 'gym_packages_state.dart';

class GymPackagesCubit extends Cubit<GymPackagesState> {
  GymPackagesCubit(this.gymPackagesRepo) : super(GymPackagesInitial());
  final GymPackagesRepo gymPackagesRepo;
}
