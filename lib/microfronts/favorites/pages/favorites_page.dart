import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quind_demo_project/microfronts/favorites/js/favorites_js.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/theme/colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static const routeName = "/";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late WebViewController controller;
  bool hasNavigated = false;
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

            controller.runJavaScript(favoritesjsScript).then((_) {
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
      ..loadRequest(Uri.parse('https://www.trivago.com/en-US/profile/favorites'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
           
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
