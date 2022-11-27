import 'package:diy/utils/libs.dart';
import 'package:diy/widget/BottomPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/bank.dart';

class SearchBankLocation extends StatelessWidget {
  SearchBankLocation({Key? key, required this.banks}) : super(key: key) {
    filteredBanks.addAll(banks);
  }

  final List<bank> banks;
  final TextEditingController searchController = TextEditingController();
  final RxList<bank> filteredBanks = RxList<bank>([]);
  Rx<bank?> selectedBank = Rx<bank?>(null);

  List<bank> filteredBanksList(String? query) {
    if (query == null || query.isEmpty) {
      return banks;
    }
    return banks
        .where(
            (bank) => bank.Branch.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomPage(
      child: Column(
        children: [
          TextField(
            controller: searchController,
            cursorColor: AppColors.primaryColor(context),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor(context)),
              ),
              hintText: 'Search',
              prefixIcon:
                  Icon(Icons.search, color: AppColors.primaryColor(context)),
            ),
            onChanged: (value) {
              filteredBanks.value = filteredBanksList(value);
            },
          ),
          WidgetHelper.verticalSpace20,
          Obx(
            () => SizedBox(
              height: 350.sp,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredBanks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.background(context),
                    elevation: 2,
                    child: Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: filteredBanks[index] == selectedBank.value,
                            onChanged: (value) {
                              selectedBank.value = filteredBanks[index];
                              selectedBank.refresh();
                            },
                            activeColor: AppColors.primaryColor(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              filteredBanks[index].Branch,
                              style: TextStyle(
                                color: AppColors.primaryContent(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                text: filteredBanks[index].Address,
                                style: TextStyle(
                                  color: AppColors.primaryContent(context),
                                  fontSize: 12.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "\nIFSC : ${filteredBanks[index].IFSC!}",
                                    style: TextStyle(
                                      color: AppColors.primaryContent(context),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          NextButton(
            text: "Submit",
            validateForm: false,
            onPressed: () async {
              if (selectedBank.value == null) {
                Get.snackbar("Error", "Please select a bank");
                return false;
              }
              getIt<FormService>().selectIfscForm.patchValue({
                'ifsc': selectedBank.value!.IFSC,
              });
              await getIt<ApiRepository>()
                  .selectIfsc(selectedBank.value!.toJson());
              final user = await getIt<OAuthService>().currentUser!;
              await getIt<OAuthService>().updateUiStatus().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, value, (route) => false));
              return true;
            },
          )
        ],
      ),
    );
  }
}
