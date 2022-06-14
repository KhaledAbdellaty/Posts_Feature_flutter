part of 'add_delete_update_bloc.dart';

abstract class AddOrDeleteOrUpdateState extends Equatable {
  const AddOrDeleteOrUpdateState();

  @override
  List<Object> get props => [];
}

class AddOrDeleteOrUpdateInitial extends AddOrDeleteOrUpdateState {}

class LoadingAddOrDeleteOrUpdate extends AddOrDeleteOrUpdateState {}

class ErrorAddOrDeleteOrUpdate extends AddOrDeleteOrUpdateState {
  final String messageError;

  const ErrorAddOrDeleteOrUpdate({required this.messageError});
  @override
  List<Object> get props => [messageError];
}

class MessageAddOrDeleteOrUpdate extends AddOrDeleteOrUpdateState {
  final String message;

  const MessageAddOrDeleteOrUpdate({required this.message});
  @override
  List<Object> get props => [message];
}
