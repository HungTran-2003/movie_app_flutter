
import 'package:flutter/material.dart';

import 'package:movie_app/common/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  ////White
  ///Montserrat

  //s16
  static final whiteMontS16 = TextStyle(color: AppColors.textWhite, fontFamily: "Montserrat", fontSize: 16);
  static final whiteMontS16SemiBold = whiteMontS16.copyWith(fontWeight: FontWeight.w600);

  ///Poppins

  //s12
  static final whitePoppinsS12Regular = TextStyle(color: AppColors.textWhite, fontFamily: "Poppins", fontSize: 12);

  //s16
  static final whitePoppinsS16Regular = TextStyle(color: AppColors.textWhite, fontFamily: "Poppins", fontSize: 16);

  //s18
  static final whitePoppinsS18Regular = TextStyle(color: AppColors.textWhite, fontFamily: "Poppins", fontSize: 18);
  static final whitePoppinsS18SemiBold = whitePoppinsS18Regular.copyWith(fontWeight: FontWeight.w600);

  ///Orange
  ///Montserrat

  //s12
  static final orangeMontS12SemiBold = TextStyle(color: AppColors.textOrange, fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.w600);

  ///Gray
  ///Montserrat

  //s12
  static final grayMontS12Medium= TextStyle(color: AppColors.textGray, fontFamily: "Montserrat", fontSize: 12);
}