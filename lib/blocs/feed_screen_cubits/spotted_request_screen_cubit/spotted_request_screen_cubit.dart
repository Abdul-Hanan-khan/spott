import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_all_spotted_requests_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'spotted_request_screen_cubit_state.dart';

class SpottedRequestScreenCubit extends Cubit<SpottedRequestScreenCubitState> {
  SpottedRequestScreenCubit() : super(SpottedRequestScreenCubitInitial());
  final Repository _repository = Repository();

  Future<void> getAllSpottedRequests(int? _postId) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(FetchingSpottRequests());
      final GetAllSpottedRequestsApiResponse _apiResponse =
          await _repository.getAllSpottRequests(AppData.accessToken!, _postId);
      if (_apiResponse.status == ApiResponse.success) {
        emit(SpottedRequestsFetchedSuccessfully(_apiResponse));
      } else {
        emit(FailedToFetchSpottRequests(_apiResponse.message));
      }
    }
  }
}
