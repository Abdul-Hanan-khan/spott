import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/report.dart';

class ReportContentApiResponse extends GeneralApiResponse{
  Report? _report;

  Report? get report => _report;

  ReportContentApiResponse({
      int? status, 
      String? message, 
      Report? report}): super(status: status,message: message){
    _report = report;
}

  ReportContentApiResponse.fromJson(dynamic json) : super.fromJson(json){
    if(json!=null){
    _report = json['report'] != null ? Report.fromJson(json['report']) : null;
    }
  }

}