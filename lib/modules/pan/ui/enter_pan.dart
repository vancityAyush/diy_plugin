// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// import '../../../widget/header.dart';
//
//
// class EnterPAN extends StatefulWidget {
//   const EnterPAN({Key? key}) : super(key: key);
//
//   @override
//   State<EnterPAN> createState() => _EnterPANState();
// }
//
// class _EnterPANState extends State<EnterPAN> {
//   TextEditingController dateinput = TextEditingController();
//   String PanName = '';
//   @override
//   Widget build(BuildContext context) {
//     final isLightMode = Theme.of(context).brightness == Brightness.light;
//
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             //top grey container
//
//             //custom appbar
//             Header(),
//             Text(
//               'Enter PAN & Date of\nBirth',
//               style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryContent(context)),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               'A PAN card is compulsory for investing in India.',
//               style: TextStyle(
//                   color: AppColors.primaryAccent(context), fontSize: 15),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Center(
//                   child: CustomTextField(
//                 label: 'Enter PAN Number',
//               )),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Container(
//                 // height: 55,
//                 decoration: BoxDecoration(
//                   color: AppColors.textFieldBackground(context),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Center(
//                   child: TextFormField(
//                     controller: dateinput,
//                     cursorColor: AppColors.primaryColor(context),
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.textFieldBackground(context),
//                         ),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: AppColors.primaryColor(context),
//                         ),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       hintText: "YYYY-MM-DD",
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.calendar_month_rounded,
//                           color: AppColors.primaryColor(context),
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context, //context of current state
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(
//                               2000), //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime(2101));
//
//                       if (pickedDate != null) {
//                         print(
//                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                         print(
//                             formattedDate); //formatted date output using intl package =>  2021-03-16
//                       } else {
//                         print("Date is not selected");
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               height: 55,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     showMaterialModalBottomSheet(
//                       context: context,
//                       builder: (context) => SingleChildScrollView(
//                         controller: ModalScrollController.of(context),
//                         child: Container(
//                           color: AppColors.background(context),
//                           height: 300,
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 CircleAvatar(
//                                   radius: 60,
//                                   backgroundColor:
//                                       AppColors.background(context),
//                                   child: Icon(
//                                     Icons.account_circle_sharp,
//                                     color: AppColors.primaryAccent(context),
//                                     size: 100,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(
//                                   'Hello, $PanName',
//                                   style: TextStyle(
//                                       color: AppColors.primaryContent(context),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12.0),
//                                   child: SizedBox(
//                                     height: 40,
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15.0),
//                                       child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           primary:
//                                               AppColors.primaryColor(context),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(4),
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           Navigator.pushNamed(
//                                               context, 'pageseven');
//                                         },
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text('Confirm name on PAN'),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Icon(Icons.arrow_forward),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Incorrect PAN?',
//                                       style: TextStyle(
//                                           color:
//                                               AppColors.primaryAccent(context)),
//                                     ),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text(
//                                           'Re-enter PAN',
//                                           style: TextStyle(
//                                               color: AppColors.primaryColor(
//                                                   context)),
//                                         ))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                     //navigate to page 6 i.e PAN name confirmation
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Continue',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       )
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                       primary: AppColors.primaryColor(context),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4))),
//                 ),
//               ),
//             ),
//
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.1,
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
