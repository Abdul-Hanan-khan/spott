part of 'rating_cubit.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingFailed extends RatingState {}

class RatingSuccess extends RatingState {
  final String? msg;

  const RatingSuccess(this.msg);
}
