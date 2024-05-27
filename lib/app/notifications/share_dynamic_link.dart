part of 'notification_helper.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
Future<void> initDynamicLinks() async {
  final PendingDynamicLinkData? initialLink =
  await FirebaseDynamicLinks.instance.getInitialLink();

  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    if (deepLink.path.isEmpty) return;
    handleDeepLink(deepLink);
  }

  dynamicLinks.onLink.listen((dynamicLinkData) {
    final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK

    final Uri path = dynamicLinkData.link;

    if (deepLink.isEmpty) return;
    handleDeepLink(path);
  }).onError((error) {
    print('onLink error');
    print(error.message);
  });
  initUniLinks();
}

Future<void> initUniLinks() async {
  try {
    final initialLink = await dynamicLinks.getInitialLink();
    if (initialLink == null) return;
    handleDeepLink(initialLink.link);
  } catch (e) {
// Error
  }
}

void handleDeepLink(Uri path) {
  log("handleDeepLink massage ${path.path.split("@").last}");
  log("handleDeepLink massage ${path.path.replaceAll('/', '')}");

  String text = path.path.replaceAll('/', '');
  RegExp regExp = RegExp(r'\d+');
  RegExpMatch? match = regExp.firstMatch(text);

    String? result = match?.group(0);
    int intValue = int.parse(result!);
    CustomNavigator.push(path.path.split("@").last??Routes.PLACE_DETAILS,
        arguments: intValue);
  log("$intValue"); // Output: 184


}
