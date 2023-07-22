import '../models/single_location_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

class SingleLocationRepository {
  
  final dio = Dio();

  Future<SingleLocationModel> fetchData(String groupId) async {
    final response = await dio.get("https://53662723-94e2-4979-9fd1-90e7825e197e.mock.pstmn.io/get_schedule?groupId=$groupId");
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.data) as Map<String, dynamic>;
      return SingleLocationModel.fromJson(jsonResponse);
    } else {
      return SingleLocationModel.withError(1);
    }

    // return SingleLocationModel();
  }
}