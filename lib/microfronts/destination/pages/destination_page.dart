import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/components/simple_appbar.dart';
import 'package:quind_demo_project/core/theme/colors.dart';
import 'package:quind_demo_project/core/utils/constants.dart';
import 'package:quind_demo_project/microfronts/destination/js/destination_js.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DestinationPage extends StatefulWidget {
  static const routeName = "/destination";
  const DestinationPage({super.key, required this.route});
  final String route;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
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

            controller.runJavaScript(destinationjsScript).then((_) {
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
      ..loadRequest(Uri.parse('${Constants.trivagoUrl}${widget.route}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: simpleAppBar(context, 'Destination', null),
      body:  SafeArea(
        child: Column(
          children: [
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
