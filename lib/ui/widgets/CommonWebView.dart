import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doctor/utility/AppUtill.dart';
import 'package:doctor/utility/CommonUIs.dart';
import 'package:doctor/values/AppSetings.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonWebView extends StatefulWidget {
  String url,title;
  CommonWebView(this.url,this.title);
  @override
  State<StatefulWidget> createState() {
    return CommonWebWidget();
  }
}

class CommonWebWidget extends State<CommonWebView> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  String latestUrl = "";

  @override
  void initState() {
    super.initState();
    AppUtill.printAppLog("url=="+widget.url);
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      latestUrl = url;
      AppUtill.printAppLog("onUrlChanged == ${url}");

    });


  }


  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: WillPopScope(child: WebviewScaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Container(
                  color: AppColors.themeColor,
                  child: Container(
                    decoration: CommonUis.getBoxDecorationTopCurved(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(widget.title,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: AppFontSize.size16,
                                      color: AppColors.black,
                                      fontFamily: AppFonts.AppFont,
                                      fontWeight: AppFontsStyle.BOLD)),
                            )
                        ),
                        IconButton(
                          onPressed: (){
                            goBack();
                          },
                          icon: SvgPicture.asset("images/close_theme_color.svg",height: 30,width: 30,),
                        ),

                      ],
                    ),
                  )
              )
          ),
          bottomNavigationBar: SizedBox(),
          allowFileURLs: true,
          withOverviewMode: true,
          url: widget.url,
          withJavascript: true,
          hidden: true,
          ignoreSSLErrors: true,
          clearCache: true,
          clearCookies: true,
        ), onWillPop: (){
          goBack();
        } as Future<bool> Function()?));
  }

  void goBack() {
    Navigator.of(context).pop({"isCompleted":false});

  }


}
