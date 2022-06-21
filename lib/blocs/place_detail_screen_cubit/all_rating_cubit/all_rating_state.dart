part of 'all_rating_cubit.dart';

abstract class AllRatingState extends Equatable {
  const AllRatingState();

  @override
  List<Object> get props => [];
}

class AllRatingInitial extends AllRatingState {}

class AllRatingSuccessState extends AllRatingState {
  final AllRatingApiResponseModel allRatingApiResponseModel;

  const AllRatingSuccessState(this.allRatingApiResponseModel);
}

class AllRatingFailedState extends AllRatingState {
  final AllRatingApiResponseModel allRatingApiResponseModel;

  const AllRatingFailedState(this.allRatingApiResponseModel);
}

class AllRatingLoadingState extends AllRatingState {}
