part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện hiện thị thông báo
class FetchNotificationEvent extends NotificationEvent {}