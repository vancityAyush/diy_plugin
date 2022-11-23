// import 'package:diy/diy.dart';
// import 'package:diy/network/api_repository.dart';
// import 'package:diy/utils/theme_files/app_colors.dart';
// import 'package:diy/widget/header.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
//
// class PanUploadPage extends StatefulWidget {
//   const PanUploadPage({Key? key}) : super(key: key);
//
//   @override
//   State<PanUploadPage> createState() => _PanUploadPageState();
// }
//
// class _PanUploadPageState extends State<PanUploadPage> {
//   final ApiRepository _apiRepository = getIt<ApiRepository>();
//
//   @override
//   Widget build(BuildContext context) {
//     final isLightMode = Theme.of(context).brightness == Brightness.light;
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Header(),
//             Text(
//               'Upload PAN Card Photo',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               'Upload a clear image of your PAN card',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: DottedBorder(
//                 color: AppColors.primaryContent(
//                     context), //color of dotted/dash line
//                 strokeWidth: 1, //thickness of dash/dots
//                 dashPattern: [4, 4],
//                 child: GestureDetector(
//                   onTap: () {
//                     print("working");
//                   },
//                   child: Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.textFieldBackground(context),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Icon(
//                             Icons.cloud_upload_outlined,
//                             color: AppColors.primaryColor(context),
//                             size: 50,
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Click here to select from gallery\nSupported: JPG, JPEG or PNG less than 10MB',
//                             style: TextStyle(
//                               color: AppColors.primaryContent(context),
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 50,
//                   width: 150,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       primary: AppColors.textFieldBackground(context),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: AppColors.primaryColor(context),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 SizedBox(
//                   height: 50,
//                   width: 150,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       primary: AppColors.textFieldBackground(context),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.image,
//                       color: AppColors.primaryColor(context),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, 'addressuploadpage');
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Next',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                       ),
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: AppColors.primaryColor(context),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Lorem ipsum | Lorem ipsum | Lorem ipsum\nCopyrights @ 2022 © Blink Trude. All Right Reserved",
//               style: TextStyle(
//                 color: AppColors.primaryAccent(context),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
