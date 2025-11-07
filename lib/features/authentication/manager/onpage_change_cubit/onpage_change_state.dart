part of 'onpage_change_cubit.dart';

sealed class OnpageChangeState extends Equatable {
  const OnpageChangeState();

  @override
  List<Object> get props => [];
}

final class OnpageChangeInitial extends OnpageChangeState {}

final class OnpageChangeSuccess extends OnpageChangeState {
  final bool isLast;

  const OnpageChangeSuccess({required this.isLast});
}
