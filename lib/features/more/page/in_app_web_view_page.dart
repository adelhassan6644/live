import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../app/core/utils/color_resources.dart';
import '../../../data/api/end_points.dart';


class MyInAppBrowser extends InAppBrowser {
  MyInAppBrowser(
      {int? windowId,
        UnmodifiableListView<UserScript>? initialUserScripts,
        PullToRefreshController? pullToRefreshController})
      : super(
    windowId: windowId,
    initialUserScripts: initialUserScripts,
    pullToRefreshController: pullToRefreshController,
  );

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {}

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
  }

  @override
  Future<PermissionResponse> onPermissionRequest(request) async {
    return PermissionResponse(
        resources: request.resources, action: PermissionResponseAction.GRANT);
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
  }

  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    print("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  void onMainWindowWillClose() {
    close();
  }
}

class InAppBrowserScreen extends StatefulWidget {
  @override
  _InAppBrowserScreenState createState() =>
      _InAppBrowserScreenState();
}

class _InAppBrowserScreenState extends State<InAppBrowserScreen> {
  late final MyInAppBrowser browser;

  @override
  void initState() {
    super.initState();

    PullToRefreshController? pullToRefreshController = kIsWeb ||
        ![TargetPlatform.iOS, TargetPlatform.android]
            .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser.webViewController?.reload();
        } else if (Platform.isIOS) {
          browser.webViewController?.loadUrl(
              urlRequest: URLRequest(
                  url: await browser.webViewController?.getUrl()));
        }
      },
    );

    browser = MyInAppBrowser(pullToRefreshController: pullToRefreshController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () async {
                        await browser.openUrlRequest(
                          urlRequest:
                          URLRequest(url: WebUri("${EndPoints.imageUrl}login")),
                          settings: InAppBrowserClassSettings(
                            browserSettings: InAppBrowserSettings(
                                toolbarTopBackgroundColor: ColorResources.WHITE_COLOR,
                                presentationStyle: ModalPresentationStyle.POPOVER),
                            webViewSettings: InAppWebViewSettings(
                              isInspectable: kDebugMode,
                              useShouldOverrideUrlLoading: true,
                              useOnLoadResource: true,
                            ),
                          ),
                        );
                      },
                      child: Text("Open In-App Browser")),
                  Container(height: 40),

                ])));
  }
}
