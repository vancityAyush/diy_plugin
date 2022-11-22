import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'header.dart';

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
    return CustomScrollView(
      controller: ModalScrollController.of(context),
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background(context),
          expandedHeight: 20.sp,
          flexibleSpace: const Header(),
        ),
        if (title != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: padding,
              child: Text(
                title!,
                style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        if (subtitle != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 20.sp),
              child: Text(
                subtitle!,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
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
                  color: AppColors.primaryAccent(context),
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
    );
  }
}
