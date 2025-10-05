import 'package:eztrainz/app/modules/purchasedetails/controllers/purchasedetails_controller.dart';
import 'package:eztrainz/app/routes/app_pages.dart';
import 'package:eztrainz/app/utils/constant/colors.dart';
import 'package:eztrainz/app/utils/widget/appbar.dart';
import 'package:eztrainz/app/utils/widget/mediumtext.dart';
import 'package:eztrainz/app/utils/widget/primarybutton.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PurchasedetailsView extends GetView<PurchasedetailsController> {
  const PurchasedetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        leftIconPath: "assets/leftArrow.png",
        rightIconPath: "assets/setting.png",
        onRightIconTap: () {
          Get.toNamed(Routes.HOME);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mediumText("Complete your purchase"),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Order summary", style: TextStyle(fontSize: 16)),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: TColors.buttonSecondary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("JLPT N5 Course", style: TextStyle(fontSize: 16)),
                    Text("1499", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(color: TColors.primary, fontSize: 16),
                    ),
                    Text(
                      "1499",
                      style: TextStyle(color: TColors.primary, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset("assets/add.png", width: 24, height: 24),
                  SizedBox(width: 10),
                  Text("Add Items", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: TColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Books", style: TextStyle(fontSize: 16)),
                        Text("140", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Study Notes", style: TextStyle(fontSize: 16)),
                        Text("140", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Practice Sheets", style: TextStyle(fontSize: 16)),
                        Text("140", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: TColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    buildMethodTile("Card", "assets/card.png"),
                    SizedBox(height: 15),
                    buildMethodTile("Bkash", "assets/bkash.png"),
                    SizedBox(height: 15),
                    buildMethodTile("Nogod", "assets/nogod.png"),
                    SizedBox(height: 15),
                    buildMethodTile("Rocket", "assets/rocket.png"),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryButton(
                    "Proceed to Pay",
                    width: 200,
                    onTap: () {
                      Get.toNamed(Routes.PAMENTSUCCESS);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMethodTile(String name, String iconPath) {
    return Obx(() {
      bool isSelected = controller.selectedMethod.value == name;
      return InkWell(
        onTap: () => controller.selectMethod(name),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : TColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 24, height: 24),
                  const SizedBox(width: 20),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              isSelected
                  ? Image.asset(
                      "assets/selectbold.png",
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
