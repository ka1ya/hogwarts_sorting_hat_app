import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat_app/bloc/score_event.dart';
import 'package:hogwarts_sorting_hat_app/bloc/score_state.dart';
import 'package:hogwarts_sorting_hat_app/models/score_model.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc() : super(ScoreInitial()) {
    on<UpdateScore>((event, emit) {
      if (state is ScoreUpdated) {
        final currentScore = (state as ScoreUpdated).score;
        final updatedScore = event.isSuccess
            ? currentScore.copyWith(
                success: currentScore.success + 1,
                total: currentScore.total + 1,
              )
            : currentScore.copyWith(
                failed: currentScore.failed + 1,
                total: currentScore.total + 1,
              );
        emit(ScoreUpdated(updatedScore));
      } else {
        final initialScore = Score(
            total: 1,
            success: event.isSuccess ? 1 : 0,
            failed: event.isSuccess ? 0 : 1);
        emit(ScoreUpdated(initialScore));
      }
    });
    on<ResetScore>((event, emit) {
      emit(ScoreUpdated(Score(total: 0, success: 0, failed: 0)));
    });
  }
}
