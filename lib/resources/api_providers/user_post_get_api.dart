import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/view_post_api_model.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/utils/constants/api_constants.dart';

class UserPostGetApi{
  
  
  Future<ViewPostApiModel>  getUserPost(int postId)async{
  final http.Response response = await http.get(Uri.parse(ApiConstants.baseUrl+ApiConstants.postViewApi+postId.toString()),
    headers: {
      'Authorization':'Bearer ${AppData.accessToken}',
      'Accept':'application/json',
      'Language':GetStorage().read('Language')??'en'
    }
    );

  if(response.statusCode == 200){
    return ViewPostApiModel.fromJson(json.decode(response.body));
  }else{
    return ViewPostApiModel(
      message: 'Data is not available',
      status: 0
    );
  }
  }
}