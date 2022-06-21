import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/search_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final Repository _repository = Repository();

  SearchCubit() : super(SearchCubitInitial());

  Future<void> search(String keyWord) async {
    if (AppData.accessToken != null) {
      emit(Searching());
      final SearchApiResponse _apiResponse = await _repository.search(
        token: AppData.accessToken!,
        keyWord: keyWord,
      );

      if (_apiResponse.status == ApiResponse.success) {
        emit(SearchedSuccessfully(_apiResponse));
      } else {
        emit(
          FailedToSearch(
            _apiResponse.message ?? LocaleKeys.failedToSearch.tr(),
          ),
        );
      }
    }
  }
}
