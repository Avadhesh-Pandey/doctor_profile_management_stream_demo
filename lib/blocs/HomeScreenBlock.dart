import 'dart:async';

import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/process/ContactProcess.dart';
import 'package:doctor/ui/DoctorDetailEditScreen.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/Loader.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenBlock{

  final _listStreamCOntroller=StreamController<List<DoctorListResponseModel>>();
  StreamSink<List<DoctorListResponseModel>> get listSink =>_listStreamCOntroller.sink;
  Stream<List<DoctorListResponseModel>> get listStream =>_listStreamCOntroller.stream;

  // final _eventStreamController=StreamController<List<DoctorDetailEditScreen>>();
  // StreamSink<List<DoctorDetailEditScreen>> get eventSink =>_eventStreamController.sink;
  // Stream<List<DoctorDetailEditScreen>> get eventStream =>_eventStreamController.stream;

  getContacts(BuildContext context)
  {
    DBProvider.db.getNotes().then((value) {
      if(value!=null && value.length>0)
      {
        AppUtill.showToast("Data Retrieved from Local Database", context);
        AppUtill.printAppLog("DBProvider.db.getNotes.length:: ${value.length}");
        listSink.add(value);
      }
      else
      {
        Loader.showLoader(context);
        ContactProcess().getAllContacts((apiResponse) {
          Loader.hideLoader();
          if(apiResponse.status)
          {
            List<DoctorListResponseModel> _doctorList=List();
            AppUtill.printAppLog("apiResponse::::${apiResponse.raw}");
            _doctorList=apiResponse.raw != null ? (apiResponse.raw as List).map((i) => DoctorListResponseModel.fromJson(i)).toList() : List();
            AppUtill.printAppLog("apiResponse::::${_doctorList.length}");

            _doctorList.forEach((element) {
              DBProvider.db.newNote(element);
            });

            DBProvider.db.getNotes().then((value) {
              AppUtill.printAppLog("DBProvider.db.getNotes.length:: ${value.length}");
              _doctorList=value;
              listSink.add(_doctorList);
            });

          }
        });
      }
    });
  }

}