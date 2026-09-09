import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'يمن إكسبرس - نسخة السايبر'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In ar, this message translates to:
  /// **'YEMEN EXPRESS CYBER'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'بوابة الدفع الموحدة المتطورة'**
  String get loginSubtitle;

  /// No description provided for @customer.
  ///
  /// In ar, this message translates to:
  /// **'عميل'**
  String get customer;

  /// No description provided for @admin.
  ///
  /// In ar, this message translates to:
  /// **'مدير النظام'**
  String get admin;

  /// No description provided for @username.
  ///
  /// In ar, this message translates to:
  /// **'اسم المستخدم'**
  String get username;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @usernameRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسم المستخدم'**
  String get usernameRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور'**
  String get passwordRequired;

  /// No description provided for @loginBtn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول للنظام'**
  String get loginBtn;

  /// No description provided for @storeTitle.
  ///
  /// In ar, this message translates to:
  /// **'متجر يمن إكسبرس المستقبلي'**
  String get storeTitle;

  /// No description provided for @smartCart.
  ///
  /// In ar, this message translates to:
  /// **'سلة التسوق الذكية'**
  String get smartCart;

  /// No description provided for @emptyCart.
  ///
  /// In ar, this message translates to:
  /// **'السلة فارغة حالياً'**
  String get emptyCart;

  /// No description provided for @actualTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي الفعلي:'**
  String get actualTotal;

  /// No description provided for @proceedToCheckout.
  ///
  /// In ar, this message translates to:
  /// **'الانتقال للبوابة والدفع المقسّم 💳'**
  String get proceedToCheckout;

  /// No description provided for @addToCart.
  ///
  /// In ar, this message translates to:
  /// **'إضافة للسلة'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافتها إلى السلة 🚀'**
  String get addedToCart;

  /// No description provided for @adminTitle.
  ///
  /// In ar, this message translates to:
  /// **'لوحة تحكم الأدمن - التحكم الشامل'**
  String get adminTitle;

  /// No description provided for @manageProducts.
  ///
  /// In ar, this message translates to:
  /// **'إدارة المنتجات'**
  String get manageProducts;

  /// No description provided for @salesAndPayments.
  ///
  /// In ar, this message translates to:
  /// **'عمليات البيع والدفع'**
  String get salesAndPayments;

  /// No description provided for @addProduct.
  ///
  /// In ar, this message translates to:
  /// **'إضافة منتج سايبر جديد'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المنتج'**
  String get editProduct;

  /// No description provided for @productName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المنتج'**
  String get productName;

  /// No description provided for @productPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر (ر.ي)'**
  String get productPrice;

  /// No description provided for @productEmoji.
  ///
  /// In ar, this message translates to:
  /// **'الرمز التعبيري الإيموجي'**
  String get productEmoji;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @totalSales.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المبيعات المحصلة:'**
  String get totalSales;

  /// No description provided for @txNo.
  ///
  /// In ar, this message translates to:
  /// **'عملية رقم:'**
  String get txNo;

  /// No description provided for @amount.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ:'**
  String get amount;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ:'**
  String get date;

  /// No description provided for @deductionWallet.
  ///
  /// In ar, this message translates to:
  /// **'محفظة الخصم:'**
  String get deductionWallet;

  /// No description provided for @splitGatewayTitle.
  ///
  /// In ar, this message translates to:
  /// **'بوابة الدفع المقسّم الذكية'**
  String get splitGatewayTitle;

  /// No description provided for @totalInvoice.
  ///
  /// In ar, this message translates to:
  /// **'الفاتورة الكلية:'**
  String get totalInvoice;

  /// No description provided for @paidAmount.
  ///
  /// In ar, this message translates to:
  /// **'المسدد:'**
  String get paidAmount;

  /// No description provided for @remainingAmount.
  ///
  /// In ar, this message translates to:
  /// **'المتبقي للسداد:'**
  String get remainingAmount;

  /// No description provided for @deductPayment.
  ///
  /// In ar, this message translates to:
  /// **'خصم دفعة'**
  String get deductPayment;

  /// No description provided for @deductVia.
  ///
  /// In ar, this message translates to:
  /// **'خصم عبر'**
  String get deductVia;

  /// No description provided for @amountToDeduct.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المراد خصمه (ر.ي)'**
  String get amountToDeduct;

  /// No description provided for @phoneWalletNo.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف / المحفظة'**
  String get phoneWalletNo;

  /// No description provided for @confirmDeduction.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد العملية وتسجيل الخصم'**
  String get confirmDeduction;

  /// No description provided for @paymentCompletedTitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتملت عملية السداد!'**
  String get paymentCompletedTitle;

  /// No description provided for @paymentCompletedMsg.
  ///
  /// In ar, this message translates to:
  /// **'تم استيفاء كامل المبلغ بنجاح عبر بوابة يمن إكسبرس الموحدة وتسجيل العملية.'**
  String get paymentCompletedMsg;

  /// No description provided for @backToStore.
  ///
  /// In ar, this message translates to:
  /// **'العودة للمتجر الرئيسي'**
  String get backToStore;

  /// No description provided for @categoryAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get categoryAll;

  /// No description provided for @categoryElectronics.
  ///
  /// In ar, this message translates to:
  /// **'إلكترونيات'**
  String get categoryElectronics;

  /// No description provided for @categoryPhones.
  ///
  /// In ar, this message translates to:
  /// **'هواتف'**
  String get categoryPhones;

  /// No description provided for @categorySolar.
  ///
  /// In ar, this message translates to:
  /// **'طاقة شمسية'**
  String get categorySolar;

  /// No description provided for @categoryYemeni.
  ///
  /// In ar, this message translates to:
  /// **'منتجات يمنية'**
  String get categoryYemeni;

  /// No description provided for @kuraimi.
  ///
  /// In ar, this message translates to:
  /// **'كريمي إكسبرس (حاسب)'**
  String get kuraimi;

  /// No description provided for @jawali.
  ///
  /// In ar, this message translates to:
  /// **'محفظة جوالي'**
  String get jawali;

  /// No description provided for @cash.
  ///
  /// In ar, this message translates to:
  /// **'محفظة كاش'**
  String get cash;

  /// No description provided for @floosak.
  ///
  /// In ar, this message translates to:
  /// **'محفظة فلوسك'**
  String get floosak;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
