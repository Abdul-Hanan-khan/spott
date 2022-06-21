part of 'spotted_list_view_cubit.dart';

abstract class SpottedListViewState extends Equatable {
  const SpottedListViewState();

  @override
  List<Object> get props => [];
}

class SpottedListViewInitial extends SpottedListViewState {}

class SpottedListViewLoading extends SpottedListViewState {}

class SpottedListViewFailedState extends SpottedListViewState {
  final SpottedPostsApiResponse placeSpottedListModel;

  SpottedListViewFailedState(this.placeSpottedListModel);
}

class SpottedListViewSuccessState extends SpottedListViewState {
  final SpottedPostsApiResponse placeSpottedListModel;

  SpottedListViewSuccessState(this.placeSpottedListModel);
}
