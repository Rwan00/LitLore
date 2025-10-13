import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum RegisterStatus { initial, loading, success, failure,emailSent }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorMessage;
  final User? user;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage ,
    this.user,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      status: RegisterStatus.initial,
     
    );
  }

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
    User? user,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user];
}


