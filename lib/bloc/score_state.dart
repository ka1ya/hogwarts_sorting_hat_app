import 'package:equatable/equatable.dart';
import 'package:hogwarts_sorting_hat_app/models/score_model.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoreInitial extends ScoreState {}

class ScoreUpdated extends ScoreState {
  final Score score;

  const ScoreUpdated(this.score);

  @override
  List<Object> get props => [score];
}
