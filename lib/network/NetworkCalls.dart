import 'dart:io';
import 'package:doctor/values/AppPrefs.dart';
import 'package:doctor/values/Keys.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'ApiResponse.dart';
import 'Apis.dart';
import 'package:dio/dio.dart';

enum RequestType { POST, GET, FORM }

class NetworkCalls {
  Dio _dio;

  NetworkCalls({baseUrl = Apis.BASE_URL}) {
    _dio = new Dio(BaseOptions(
      baseUrl: Apis.BASE_URL,
      headers: {HttpHeaders.acceptHeader: "application/json"},
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
    _dio.options.headers["Authorization"] = "Bearer ${AppPrefs.getInstance().getStringData(Keys.AUTH_TOCKEN)}";
  }

  Future forRequest(void ApiResult(ApiResponse apiResponce), url, requestType,
      {RequestParam = null}) async {
    AppUtill.printAppLog('request url = ${url}');
    if (RequestParam != null && requestType != RequestType.FORM)
      AppUtill.printAppLog('request data = ${jsonEncode(RequestParam)}');

    Response response;

    try{
      if (requestType == RequestType.POST) {
        response = await _dio.post(url, data: jsonEncode(RequestParam));
      } else if (requestType == RequestType.FORM) {
        response = await _dio.post(url, data: RequestParam);
      } else if (requestType == RequestType.GET) {
        response = await _dio.get(url);
      }

      AppUtill.printAppLog("response status == ${response.statusCode}");
      AppUtill.printAppLog("response result == ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
      Map raw = JsonCodec().decode(jsonEncode(response.data));
        ApiResponse apiResponce = ApiResponse.fromJson(response.data);
        apiResponce.raw=raw;
        apiResponce.statusCode=response.statusCode;

        ApiResult(apiResponce);
      }

    }
    on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if(e.response != null) {
        ApiResponse apiResponse;
        var data=e.response.data;
        apiResponse=new ApiResponse.fromJson(data);
        apiResponse.status=false;
        print(data);
        print(e.response.headers);
        // print(e.response.request);
        print(e.response.statusCode);
        apiResponse.statusCode=e.response.statusCode;
        ApiResult(apiResponse);

      }
      else if (e.type == DioErrorType.connectTimeout) {
        ApiResponse apiResponse;
        {
          apiResponse=new ApiResponse.fromJson({"status":false,"message":"Please check your internet connection & try again later","data":[]});
        }
        apiResponse.statusCode=110;
        apiResponse.status=false;
        ApiResult(apiResponse);
      }
      else if (e.type == DioErrorType.receiveTimeout) {
        ApiResponse apiResponse;
        {
          apiResponse=new ApiResponse.fromJson({"status":false,"message":"Please check your internet connection & try again later","data":[]});
        }
        apiResponse.statusCode=110;
        apiResponse.status=false;
        ApiResult(apiResponse);
      }
      else{
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
      }
    }
    catch(e,stackTrace)
    {
      ApiResponse apiResponse;
      {
        apiResponse=new ApiResponse.fromJson({"status":false,"message":"Some error occurred please try again later","data":[]});
      }
      ApiResult(apiResponse);

      AppUtill.printAppLog('Exception1==${e.toString()}');
      AppUtill.printAppLog('Exception2==$stackTrace');
    }

  }

  static Future uploadImage(
      void ApiResult(ApiResponse apiResponce), url, File fileToUpload,
      {field = "image"}) async {
    AppUtill.printAppLog('request url = ${url}');

    final mimeTypeData =
        lookupMimeType(fileToUpload.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(field, fileToUpload.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      AppUtill.printAppLog("response status == ${response.statusCode}");
//      AppUtill.printAppLog("response result == ${jsonEncode(response.body)}");
      final Map<String, dynamic> responseData = json.decode(response.body);

      AppUtill.printAppLog("response result == ${jsonEncode(responseData)}");

      if (response.statusCode == 200) {
        ApiResponse apiResponce = ApiResponse.fromJson(responseData);
        ApiResult(apiResponce);
      }

    } catch (e) {
      print(e);
    }
  }
}
