import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailEditScreen.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:flutter/cupertino.dart';

final viewStreamController=StreamController<DoctorListResponseModel?>.broadcast();

class DoctorDetailViewBlock{

  StreamSink<DoctorListResponseModel?> get viewSink =>viewStreamController.sink;
  Stream<DoctorListResponseModel?> get viewStream =>viewStreamController.stream;
}