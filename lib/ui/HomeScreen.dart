import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/blocs/HomeScreenBlock.dart';
import 'package:doctor/data/Database.dart';
import 'package:doctor/model/DoctorListResponseModel.dart';
import 'package:doctor/ui/DoctorDetailScreen.dart';
import 'package:doctor/ui/widgets/ContactListItemWidget.dart';
import 'package:doctor/ui/widgets/CoroselSliderItemWidget.dart';
import 'package:doctor/utility/AppDialog.dart';
import 'package:doctor/utility/CustomAlertDialog.dart';
import 'package:doctor/values/AppPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeWidget();
  }
}


class HomeWidget extends State<HomeScreen> {
  late Size _size;
  HomeScreenBlock _homeScreenBlock=HomeScreenBlock();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _homeScreenBlock.getContacts(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(child:
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
      ),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("images/bima_doctor_name_logo.png",fit: BoxFit.fitWidth,),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('What We Do'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('News and Awards'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            Padding(padding: EdgeInsets.only(top: 20,right: 20,left: 20),child: CommonUis.getThemeRaisedButton("LOGOUT", () {

              CustomAlertDialog.show(context, AppDialog.DIALOG_INFO, "Are you sure you want to logout ? ",
                  title: "",buttonText: "Cancel" ,isNegativeButtonVisible: true,
                  negativeButtonText: "Confirm",
                  onNegativeButtonClicked: ()
                  {
                    AppPrefs.getInstance()!.setLogout(true);
                    DBProvider.db.deleteAll();
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/login');
                  },
                  /*onPositiveButtonClicked: ()
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SubmitCannedCodesScreen(scannedCodesList);
                            }));
                      },*/image: "images/info_icon.svg");

            }),)

          ],
        ),
        ),
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.themeColor, //change your color here
          ),
          titleSpacing: 0,
          elevation: 1,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/bima_doctor_name_logo.png",height: 50,),
              Image.asset("images/bima_logo.png",height: 50,fit: BoxFit.fitHeight,),
            ],
          ),
        ),
        body:LayoutBuilder(builder: (context,constraints)
          {
            return Column(
              children: [
                StreamBuilder(
                  stream: _homeScreenBlock.carouselSliderStream,
                  initialData: null,
                  builder: (BuildContext context,AsyncSnapshot snap)
                  {
                    List<DoctorListResponseModel>? _list=snap.data;
                    return snap.data==null?SizedBox():
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: AppUtill.getSize(_size.height, 20),
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                          Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {

                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        items: _list!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                child: ClipRRect(
//                                  borderRadius: BorderRadius.circular(20),
                                  child: CoroselSliderItemWidget(i),
                                ),
                                onTap: () {
                                  // gotoBannersNavigationURL(i);
                                },
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  stream: _homeScreenBlock.listStream,
                  initialData: [],
                  builder: (BuildContext context,AsyncSnapshot snapshot)
                  {
                    AppUtill.printAppLog("DBProvider.db.getNotes.length3:: ${snapshot.data.length}");
                    return Flexible(child: ListView.separated(
                        itemBuilder: (_, index){
                      return ContactListItemWidget(snapshot.data[index],onSelected: ()
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return DoctorDetailScreen(snapshot.data[index]);
                            }));
                      },);
                    }, separatorBuilder: (context, index) => Divider(
                    ), itemCount: snapshot.data.length));
                  },
                )
              ],
            );
          },)
      ),

    ), onWillPop: (){
      Navigator.pop(context);
      exit(0);
    } as Future<bool> Function()?);
  }
}

