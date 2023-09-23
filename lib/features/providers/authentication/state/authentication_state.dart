import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

part "authentication_state.freezed.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.loading() = _Loading;

  const factory AuthenticationState.unauthenticated({required AppException message}) =
      _UnAuthentication;

  const factory AuthenticationState.authenticated({required User user}) =
      _Authenticated;
}
