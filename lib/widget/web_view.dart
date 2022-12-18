// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebViewScreen extends StatelessWidget {
//   final String url;
//   final String title;
//   WebViewScreen({Key? key, required this.url, required this.title})
//       : super(key: key) {
//     _bloc = WebViewBloc(url);
//   }
//   late WebViewBloc _bloc;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         elevation: 0,
//       ),
//       body: StreamBuilder<bool>(
//           stream: _bloc.loadingStream,
//           initialData: true,
//           builder: (context, snapshot) {
//             return Stack(
//               children: [
//                 InAppWebView(
//                   initialOptions: InAppWebViewGroupOptions(
//                     android: AndroidInAppWebViewOptions(
//                       useHybridComposition: true,
//                     ),
//                     crossPlatform: InAppWebViewOptions(
//                       cacheEnabled: false,
//                       clearCache: true,
//                     ),
//                   ),
//                   initialUrlRequest: URLRequest(url: Uri.parse(url)),
//                   onLoadStart: _bloc.onPageLoadStart,
//                   onWebViewCreated: (controller) async {
//                     _bloc.webViewController = controller;
//                     await _bloc.initCreation();
//                   },
//                   onReceivedServerTrustAuthRequest:
//                       (controller, challenge) async {
//                     return ServerTrustAuthResponse(
//                       action: ServerTrustAuthResponseAction.PROCEED,
//                     );
//                   },
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
//
// class WebViewBloc {
//   String loadUrl;
//
//   @override
//   void dispose() {
//     _loadingController.close();
//   }
//
//   WebViewBloc(this.loadUrl);
//
//   String? url;
//   InAppWebViewController? webViewController;
//   final StreamController<bool> _loadingController = StreamController();
//   Stream<bool> get loadingStream => _loadingController.stream;
//
//   void onPageLoadStart(InAppWebViewController? controller, Uri? uri) {
//     _loadingController.sink.add(true);
//     url = uri.toString();
//   }
//
//   Future<void> initCreation() async {
//     await webViewController!
//         .loadUrl(urlRequest: URLRequest(url: Uri.parse(loadUrl)));
//     await Future.delayed(const Duration(seconds: 3));
//     _loadingController.sink.add(false);
//   }
// }
