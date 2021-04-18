part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppLogOutRequested extends AppEvent {
  const AppLogOutRequested();
  @override
  List<Object?> get props => [];
}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}
