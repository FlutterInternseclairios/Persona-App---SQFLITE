// part of 'authentication_bloc.dart';

// enum AuthenticationStatus { authenticated, unauthenticated, unknown }

// sealed class AuthenticationState extends Equatable {
//   const AuthenticationState._(
//       {this.status = AuthenticationStatus.unknown, this.userModel});
//   final AuthenticationStatus status;
//   final UserModel? userModel;

//   const AuthenticationState.unknown() : this._();

//   const AuthenticationState.authenticated(UserModel userModel)
//       : this._(
//             status: AuthenticationStatus.authenticated, userModel: userModel);

//   const AuthenticationState.unauthenticated()
//       : this._(status: AuthenticationStatus.unauthenticated);

//   @override
//   List<Object?> get props => [status, userModel];
// }
