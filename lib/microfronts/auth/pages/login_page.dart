import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/routes/resource_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/constants.dart';
import '../js/login_js.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/auth";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController controller;
  InAppWebViewController? webViewController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..addJavaScriptChannel('FlutterChannel',
    //       onMessageReceived: (JavaScriptMessage message) {
    //     log('Mensaje recibido de JavaScript: ${message.message}');
    //     if (message.message == 'navigateHome') {
    //       Navigator.pushNamed(context,
    //           HomePage.routeName);
    //     }
    //   })
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar
    //       },
    //       onPageStarted: (String url) {
    //         log('Page started loading: $url');
    //         setState(() {
    //           isLoading = true;
    //         });
    //       },
    //       onPageFinished: (String url) {
    //         log('Page finished loading: $url');

    //         controller.runJavaScript(loginjsScript).then((_) {
    //           setState(() {
    //             isLoading = false;
    //           });
    //         });
    //       },
    //       onHttpError: (HttpResponseError error) {
    //         log('HTTP error: ${error.response}');
    //       },
    //       onNavigationRequest: (NavigationRequest request) async {
    //         final  token = await controller.runJavaScriptReturningResult(
    //             "sessionStorage.getItem('uxa.visit_id');");

    //         log("token: $token");
    //         if (token != "") {
    //           // ignore: use_build_context_synchronously
    //           Navigator.pushNamed(context, MenuBottomPage.routeName);
    //           return NavigationDecision.prevent;
    //         }

    //         return NavigationDecision.navigate;
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //         log('Web resource error: ${error.description}');
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(Constants.dropboxUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(loginImage),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: Column(
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
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        initialSettings: InAppWebViewSettings(
                          clearCache: false,
                          javaScriptEnabled: true,
                          safeBrowsingEnabled: false,
                          useShouldOverrideUrlLoading: true,
                          supportMultipleWindows: true,
                          transparentBackground: true,
                        ),
                        initialUrlRequest: URLRequest(
                          url: WebUri(Constants.dropboxUrl),
                        ),
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          // any code;
                          return NavigationActionPolicy.ALLOW;
                        },
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                          // Añade el JavaScriptHandler
                          webViewController!.addJavaScriptHandler(
                            handlerName: 'flutterHandler',
                            callback: (args) {
                              log('Evento recibido de JavaScript: $args');
                              // Puedes hacer algo con los datos recibidos desde JavaScript
                              return null;
                            },
                          );
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) async {
                          // if (url.toString().contains("hotel")) {
                          //   Navigator.pushReplacementNamed(
                          //       context, DestinationPage.routeName,
                          //       arguments: url.toString());
                          //   //You can do anything
                          //   log('entró');
                          //   //Prevent that url works
                          //   return;
                          // }

                          // var token =
                          //     await webViewController?.evaluateJavascript(
                          //         source:
                          //             "sessionStorage.getItem('uxa.visit_id');");
                        
                          // if (token != "") {
                          //   // // ignore: use_build_context_synchronously
                          //   Navigator.pushNamed(
                          //       context, MenuBottomPage.routeName);
                          // }

                          // get cookies
                        },
                        onLoadStart: (controller, url) {
                          log("Started loading: $url");
                          setState(() {
                            isLoading = true;
                          });
                        },
                        onLoadStop: (controller, url) {
                          log("Finished loading: $url");

                          webViewController!
                              .evaluateJavascript(source: loginjsScript)
                              .then((_) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                      ),
                      if (isLoading)
                        Expanded(
                            child: Container(
                          color: scaffoldColor,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                        ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
