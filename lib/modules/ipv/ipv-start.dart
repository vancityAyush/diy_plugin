import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:diy/widget/web_view_2.dart';
import 'package:flutter/material.dart';

import '../../diy.dart';
import '../../network/api_repository.dart';

class IpvStart extends StatelessWidget {
  IpvStart({
    Key? key,
  }) : super(key: key);

  final apiRepository = getIt<ApiRepository>();

  @override
  Widget build(BuildContext context) {
    return BottomPage(
      title: "Please Read the Code  ",
      subtitle: "Please Read the above Code Loud and Clear",
      child: Column(
        children: [
          NextButton(
            text: 'Start IPV',
            onPressed: () async {
              final res = await apiRepository.startIPV();
              final data = res["Data"] as List<dynamic>;
              final m = getIt<OAuthService>().currentUser!.Mobile!;
              // final url =
              //     "https://newdiy.cloudyhr.com/diy/digio?m=$m&env=${data[0]}&id=${data[1]}&t=${data[2]}";
              final url = data[1];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewApp(url: url)));
              return true;
            },
          )
        ],
      ),
    );
  }
}
