import 'package:flutter/material.dart';

import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/configs/app_configs.dart';

class AppTextStyle {
  AppTextStyle._();

  ////White
  ///Montserrat

  //s16
  static final whiteMontS16 = TextStyle(
    color: AppColors.textWhite,
    fontFamily: AppConfigs.fontMontserrat,
    fontSize: 16,
  );
  static final whiteMontS16SemiBold = whiteMontS16.copyWith(
    fontWeight: FontWeight.w600,
  );

  ///Poppins

  //s12
  static final whitePoppinsS12Regular = TextStyle(
    color: AppColors.textWhite,
    fontFamily: AppConfigs.fontPoppins,
    fontSize: 12,
  );

  //s16
  static final whitePoppinsS16Regular = TextStyle(
    color: AppColors.textWhite,
    fontFamily: AppConfigs.fontPoppins,
    fontSize: 16,
  );

  //s18
  static final whitePoppinsS18Regular = TextStyle(
    color: AppColors.textWhite,
    fontFamily: AppConfigs.fontPoppins,
    fontSize: 18,
  );
  static final whitePoppinsS18SemiBold = whitePoppinsS18Regular.copyWith(
    fontWeight: FontWeight.w600,
  );

  ///Orange
  ///Montserrat

  //s12
  static final orangeMontS12SemiBold = TextStyle(
    color: AppColors.textOrange,
    fontFamily: AppConfigs.fontMontserrat,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  ///Gray
  ///Montserrat

  //s12
  static final grayMontS12Medium = TextStyle(
    color: AppColors.textGray,
    fontFamily: AppConfigs.fontMontserrat,
    fontSize: 12,
  );
}
