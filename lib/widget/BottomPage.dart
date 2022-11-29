import 'package:diy/diy.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../network/oauth_service.dart';

class BottomPage extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final EdgeInsets padding;
  const BottomPage(
      {Key? key,
      required this.child,
      this.title,
      this.subtitle,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.background(context),
        child: Builder(
          builder: (context) {
            final uiStatus = getIt<OAuthService>().uiStatus;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jump to',
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryContent(context))),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close_rounded))
                    ],
                  ),
                ),
                Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  color: AppColors.primaryContent(context),
                ),
                ListTile(
                  title: Text(
                    "Resume Journey",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor(context)),
                  ),
                  onTap: () {
                    getIt<OAuthService>().updateUiStatus().then((route) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        route,
                        (route) => false,
                        arguments: {kReadOnly: false},
                      );
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.verified,
                        color: AppColors.primaryColor(context),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "VERIFY",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryContent(context),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int index in uiStatus.BackMenuList)
                  ListTile(
                    title: Text(
                      uiStatus.titles[index] ?? '',
                      style: TextStyle(color: AppColors.primaryAccent(context)),
                    ),
                    onTap: () {
                      String? route = uiStatus.modules[index];
                      Navigator.pushNamed(
                        context,
                        uiStatus.modules[index] ?? "/",
                        arguments: {
                          kReadOnly: true,
                        },
                      );
                    },
                  )
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        foregroundColor: AppColors.primaryContent(context),
        elevation: 0,
        title: Center(
          child: Image(
            image: AssetImage(
                isLightMode ? 'assets/logo-light.png' : 'assets/logo-dark.png',
                package: "diy"),
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       //Navigator.of(context).pop();
        //     },
        //     icon: Icon(
        //       Icons.power_settings_new_rounded,
        //       size: 25,
        //       color: AppColors.primaryAccent(context),
        //     ),
        //   ),
        // ],

        automaticallyImplyLeading:
            getIt<OAuthService>().uiStatus.BackMenuList.isNotEmpty,
      ),
      body: CustomScrollView(
        controller: ModalScrollController.of(context),
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (title != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 60.sp),
                child: Padding(
                  padding: padding,
                  child: Text(
                    title!,
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryContent(context)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (subtitle != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20.sp, left: 20.sp, right: 20.sp),
                child: Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subHeading(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(
              child: child,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Copyrights @ 2022 © Blink Trude. All Right Reserved",
                  style: TextStyle(
                    color: AppColors.footerText(context),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
