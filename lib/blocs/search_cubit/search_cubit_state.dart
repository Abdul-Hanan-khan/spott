part of 'search_cubit.dart';

abstract class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object> get props => [];
}

class SearchCubitInitial extends SearchCubitState {}

class Searching extends SearchCubitState {}

class FailedToSearch extends SearchCubitState {
  final String message;

  const FailedToSearch(this.message);
}

class SearchedSuccessfully extends SearchCubitState {
  final SearchApiResponse apiResponse;

  const SearchedSuccessfully(this.apiResponse);
}
