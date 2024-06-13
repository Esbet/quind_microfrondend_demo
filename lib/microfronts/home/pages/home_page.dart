import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quind_demo_project/microfronts/home/js/home_js.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/routes/resource_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
            setState(() {
              isLoading = true; 
            });
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');

            controller.runJavaScript(homejsScript).then((_) {
              setState(() {
                isLoading = false; 
              });
            });
          },
          onHttpError: (HttpResponseError error) {
            log('HTTP error: ${error.response}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            log('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.trivago.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey David",
                        style: textBigBold22(secondColor),
                      ),
                      Text(
                        "Where do you go?",
                        style: textBlackStyleSubTitle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          userProfile,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            isLoading
                ? const Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  ))
                : Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }
}
