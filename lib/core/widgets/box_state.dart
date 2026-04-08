import 'package:equatable/equatable.dart';

enum RequestState { initial, loading, success, error }

class BoxState<T> extends Equatable {
  final String? errMsg;
  final T? data;
  final RequestState requestState;
  const BoxState({
    this.errMsg,
    this.data,
    this.requestState = RequestState.initial,
  });

  bool get isLoading => requestState == RequestState.loading;
  bool get isSuccess => requestState == RequestState.success;
  bool get isError => requestState == RequestState.error;
  bool get isInitial => requestState == RequestState.initial;

  const BoxState.initial() : this(requestState: RequestState.initial);
  const BoxState.loading() : this(requestState: RequestState.loading);
  const BoxState.success({required T data})
    : this(data: data, requestState: RequestState.success);
  const BoxState.successWithoutData()
    : this(requestState: RequestState.success);
  const BoxState.error({required String errMsg})
    : this(requestState: RequestState.error, errMsg: errMsg);

  @override
  List<Object?> get props => [errMsg, data, requestState];
}
