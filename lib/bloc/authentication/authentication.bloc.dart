import 'package:flutter/cupertino.dart';
import 'package:flutter_app/bloc/authentication/authentication.event.dart';
import 'package:flutter_app/bloc/authentication/authentication.state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app/repositories/user-repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  _mapLoggedInState() async* {
    yield Authenticated(await _userRepository.getUser());
  }

  _mapLoggedOutState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
