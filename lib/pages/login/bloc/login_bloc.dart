import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/core/validators/login.validator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> next(LoginEvent event),
  ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(
      Duration(milliseconds: 300),
    );
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGoogleToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: LoginValidator.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: LoginValidator.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsToState({password, email}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
