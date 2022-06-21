part of 'spotted_request_screen_cubit.dart';

abstract class SpottedRequestScreenCubitState extends Equatable {
  const SpottedRequestScreenCubitState();

  @override
  List<Object> get props => [];
}

class SpottedRequestScreenCubitInitial extends SpottedRequestScreenCubitState {}

class FetchingSpottRequests extends SpottedRequestScreenCubitState {}

class FailedToFetchSpottRequests extends SpottedRequestScreenCubitState {
  final String? message;

  const FailedToFetchSpottRequests(this.message);
}

class SpottedRequestsFetchedSuccessfully
    extends SpottedRequestScreenCubitState {
  final GetAllSpottedRequestsApiResponse apiResponse;

  const SpottedRequestsFetchedSuccessfully(this.apiResponse);
}
