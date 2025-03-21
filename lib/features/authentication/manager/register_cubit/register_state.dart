part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String errorMsg;

  const RegisterFailure({required this.errorMsg});
}

final class RegisterSuccess extends RegisterState {
  final User? user;

  const RegisterSuccess({required this.user});
}
final class VirificationFailure extends RegisterState {
  final String errorMsg;

  const VirificationFailure({required this.errorMsg});
}

final class VirificationrSuccess extends RegisterState {
}

