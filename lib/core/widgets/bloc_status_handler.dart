import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';

class BlocStatusHandler<C extends Cubit<S>, S> extends StatelessWidget {
  final Widget body;
  final VoidCallback onRetry;
  final bool Function(S state) isNetwork;
  final bool Function(S state) isError;
  final bool Function(S previous, S current)? buildWhen;

  const BlocStatusHandler({
    super.key,
    required this.body,
    required this.onRetry,
    required this.isNetwork,
    required this.isError,
    this.buildWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      buildWhen: buildWhen,
      builder: (context, state) {
        if (isNetwork(state)) {
          return NoInternetWidget(onRetry: onRetry);
        } else if (isError(state)) {
          return MyErrorWidget(onRetry: onRetry);
        }
        return body;
      },
    );
  }
}
