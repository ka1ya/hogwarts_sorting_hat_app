import 'package:equatable/equatable.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class UpdateScore extends ScoreEvent {
  final bool isSuccess;

  const UpdateScore(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}

class ResetScore extends ScoreEvent {}
