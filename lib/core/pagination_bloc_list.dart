import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';

class PaginatedBlocList<T, CubitType extends Cubit<StateType>, StateType>
    extends StatefulWidget {
  final Future<void> Function() onLoadMore;
  final bool Function(StateType) isPaginationLoading;
  final bool Function(StateType) isLoading;
  final bool Function(StateType) isData;
  final List<T> Function(StateType) onData;
  final Widget Function(T item, int index) itemBuilder;
  final String emptyTitle;
  final String emptyMessage;

  final bool Function(StateType, StateType)? buildWhen;

  const PaginatedBlocList({
    super.key,
    required this.isLoading,
    required this.isData,
    required this.isPaginationLoading,
    required this.onData,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.emptyTitle,
    required this.emptyMessage,
    this.buildWhen,
  });

  @override
  State<PaginatedBlocList<T, CubitType, StateType>> createState() =>
      _PaginatedBlocListState<T, CubitType, StateType>();
}

class _PaginatedBlocListState<T, CubitType extends Cubit<StateType>, StateType>
    extends State<PaginatedBlocList<T, CubitType, StateType>> {
  List<T> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitType, StateType>(
      buildWhen: widget.buildWhen,
      builder: (context, state) {
        if (widget.isLoading(state)) {
          return Center(
            child: SpinKitFadingCircle(color: AppColors.primaryColor, size: 50),
          );
        } else if (widget.isData(state)) {
          final newItems = widget.onData(state);
          if (newItems.isNotEmpty) {
            items.addAll(newItems);
          }
        }

        return items.isEmpty
            ? EmptyStateWidget(
                title: widget.emptyTitle,
                message: widget.emptyMessage,
              )
            : PaginationListener(
                onLoadMore: widget.onLoadMore,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 5),
                        itemBuilder: (context, index) =>
                            widget.itemBuilder(items[index], index),
                      ),
                    ),
                    BlocBuilder<CubitType, StateType>(
                      builder: (context, state) {
                        return widget.isPaginationLoading(state)
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
