import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/menu/menu_bottom_page.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';
import 'package:quind_demo_project/microfronts/auth/js/login_js.dart';
import 'package:quind_demo_project/microfronts/home/pages/home_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/routes/resource_icons.dart';
import '../../../core/utils/constants.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/auth";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController controller;

  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel('FlutterChannel',
          onMessageReceived: (JavaScriptMessage message) {
        log('Mensaje recibido de JavaScript: ${message.message}');
        if (message.message == 'navigateHome') {
          Navigator.pushNamed(context,
              HomePage.routeName); 
        }
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
            setState(() {
              isLoading = true; 
            });
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');
      
            controller.runJavaScript(loginjsScript).then((_) {
              setState(() {
                isLoading = false; 
              });
            });
          },
          onHttpError: (HttpResponseError error) {
            log('HTTP error: ${error.response}');
          },
          onNavigationRequest: (NavigationRequest request) async {
            final  token = await controller.runJavaScriptReturningResult(
                "sessionStorage.getItem('uxa.visit_id');");

            log("token: $token");
            if (token != "") {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, MenuBottomPage.routeName);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            log('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(Constants.dropboxUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
                loginImage), 
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: NeverScrollableScrollPhysics(),
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Login",
                        style: textBlackStyleTitle,
                      ),
                      isLoading?
                      SizedBox(
                        height:60.h,
                        child: const Center(child: CircularProgressIndicator()))
                      :
                      SizedBox(
                        height: 60.h,
                        child: WebViewWidget(controller: controller),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
