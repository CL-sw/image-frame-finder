import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:neigbuy_flutter_app/app/model/misc/alipay_response.dart';
import 'package:neigbuy_flutter_app/app/model/misc/boc_alipay_response.dart';
import 'package:neigbuy_flutter_app/app/model/misc/order_deal_pickup_point_item.dart';
import 'package:neigbuy_flutter_app/app/model/misc/payme_response.dart';
import 'package:neigbuy_flutter_app/app/model/misc/payment_method.dart';
import 'package:neigbuy_flutter_app/app/model/response/deal_group_base_response.dart';
import 'package:neigbuy_flutter_app/app/model/response/shipping/pickup_suggestion.dart';
import 'package:neigbuy_flutter_app/app/model/response/text_message_token.dart';
import 'package:neigbuy_flutter_app/app/model/response/user_cart.dart';
import 'package:neigbuy_flutter_app/app/model/response/user_shipping.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/enum_cart.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_alipay.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_mpgs_3ds.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_cart.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_credit_card.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_new_pick_up_point_sf_address.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_new_spu.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_payme.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_submit_code.dart';
import 'package:neigbuy_flutter_app/ui/page/cart/page_vces.dart';
import 'package:neigbuy_flutter_app/ui/page/coupon/page_coupon.dart';
import 'package:neigbuy_flutter_app/ui/page/coupon/page_coupon_list.dart';
import 'package:neigbuy_flutter_app/ui/page/landing/page_password_login.dart';
import 'package:neigbuy_flutter_app/ui/page/landing/page_phone_input.dart';
import 'package:neigbuy_flutter_app/ui/page/landing/signup/page_reset_password.dart';
import 'package:neigbuy_flutter_app/ui/page/landing/signup/page_phone_verification_code.dart';
import 'package:neigbuy_flutter_app/ui/page/landing/page_splash.dart';
import 'package:neigbuy_flutter_app/ui/page/main/page_deal_detail.dart';
import 'package:neigbuy_flutter_app/ui/page/main/page_main.dart';
import 'package:neigbuy_flutter_app/ui/page/media/page_image_viewer.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_account.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_n_dollar_logs.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_notification_setting.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_payment_method.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_point_history.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_profile_edit.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_feedback.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/account/page_redemption_list.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/page_pickup_code.dart';
import 'package:neigbuy_flutter_app/ui/page/menu/page_referral.dart';
import 'package:neigbuy_flutter_app/ui/page/message_hub/page_message_hub.dart';
import 'package:neigbuy_flutter_app/ui/page/misc/page_not_found.dart';
import 'package:neigbuy_flutter_app/ui/page/order/page_intangible_good_voucher.dart';
import 'package:neigbuy_flutter_app/ui/page/pickup_notification/page_pickup_notification.dart';
import 'package:neigbuy_flutter_app/ui/page/search/page_search_result.dart';
import 'package:neigbuy_flutter_app/ui/page/webview/page_webview.dart';
import 'package:neigbuy_flutter_app/ui/page/message_hub/page_message_detail.dart';
import 'package:neigbuy_flutter_app/ui/page/order/page_order.dart';
import 'package:neigbuy_flutter_app/ui/page/order/page_order_detail.dart';
import 'package:neigbuy_flutter_app/ui/page/shipping/page_add_shipping.dart';
import 'package:neigbuy_flutter_app/ui/page/shipping/page_shipping_address_info.dart';
import 'package:quiver/strings.dart';

import '../page/cart/page_boc_alipay.dart';
import '../page/fnb_map/page_fnb_map.dart';
import '../page/search/page_search.dart';

// region Unknown
final unknownHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return Container();
  },
);
// endregion

// region Landing
final splashHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const SplashPage();
    });

final phoneInputHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const PhoneInputPage();
    });

final passwordLoginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final phone = params[PasswordLoginPage.kPhone]!.first;
      return PasswordLoginPage(phone);
    });

final phoneVerificationCodeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final phone = params[PhoneVerificationCodePage.kPhone]!.first;
      final isCreateAccountStr = params[PhoneVerificationCodePage.kIsCreateAccount]?.first;
      bool isCreateAccount = true;
      if (isCreateAccountStr != null) {
        isCreateAccount = isCreateAccountStr.toLowerCase() == 'true';
      }
      return PhoneVerificationCodePage(phone, isCreateAccount: isCreateAccount);
    });

final resetPasswordHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final phone = params[ResetPasswordPage.kPhone]!.first;
      final tokenStr = params[ResetPasswordPage.kToken]?.first;
      TextMessageToken? token;
      if (isNotEmpty(tokenStr)) {
        token = TextMessageToken.fromJson(json.decode(tokenStr!));
      }
      return ResetPasswordPage(phone, token: token);
    });
// endregion

// region Main
final mainHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final pageName = params[MainPage.kPageName]?.first;
      final tabName = params[MainPage.kTabName]?.first;
      final liveId = params[MainPage.kLiveId]?.first;
      final dealUrlKey = params[MainPage.kDealUrlKey]?.first;
      final shortenLink = params[MainPage.kShortenLink]?.first;
      final thematicPromotionUrlKey = params[MainPage.kThematicPromotionUrlKey]?.first;
      return MainPage(
        pageName: pageName,
        tabName: tabName,
        liveId: liveId,
        dealUrlKey: dealUrlKey,
        shortenLink: shortenLink,
        thematicPromotionUrlKey: thematicPromotionUrlKey,
      );
    });

final dealDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final dealGroupId = params[DealDetailPage.kDealGroupId]?.first;
      final isLive = params[DealDetailPage.kIsLive]?.first == 'true';
      final isOpenFromCart = params[DealDetailPage.kIsOpenFromCart]?.first == 'true';
      final isOpenFromVideoPlayIcon = params[DealDetailPage.kIsOpenFromVideoPlayIcon]?.first == 'true';
      return DealDetailPage(
        dealGroupId: dealGroupId,
        isLive: isLive,
        isOpenFromCart: isOpenFromCart,
        isOpenFromVideoPlayIcon: isOpenFromVideoPlayIcon,
      );
    });
// endregion

// region Shipping
final addShippingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final userCartStr = params[AddShippingPage.kUserCart]?.first;
      final orderDealPickupPointItemStr = params[AddShippingPage.kOrderDealPickupPointItem]?.first;
      final shippingTypeStr = params[AddShippingPage.kShippingType]!.first;
      final isBackupStr = params[AddShippingPage.kIsBackup]?.first;
      final isFromCartStr = params[AddShippingPage.kIsFromCart]?.first;
      UserCart? userCart;
      if (isNotEmpty(userCartStr)) {
        userCart = UserCart.fromJson(json.decode(userCartStr!));
      }
      OrderDealPickupPointItem? orderDealPickupPointItem;
      if (isNotEmpty(orderDealPickupPointItemStr)) {
        orderDealPickupPointItem = OrderDealPickupPointItem.fromJson(json.decode(orderDealPickupPointItemStr!));
      }
      final shippingType = ShippingType.values.firstWhere((v) => v.name == shippingTypeStr);
      bool isBackup = false;
      if (isBackupStr != null) {
        isBackup = isBackupStr.toLowerCase() == 'true';
      }
      bool isFromCart = false;
      if (isFromCartStr != null) {
        isFromCart = isFromCartStr.toLowerCase() == 'true';
      }
      return AddShippingPage(shippingType,userCart:userCart,orderDealPickupPointItem: orderDealPickupPointItem, isBackup: isBackup, isFromCart:isFromCart);// orderDeal:orderDeal, popularPickup:popularPickup, isBackup: isBackup);
    });

final shippingAddressInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final userCartStr = params[ShippingAddressInfoPage.kUserCart]!.first;
      final userShippingStr = params[ShippingAddressInfoPage.kUserShipping]?.first;
      final userCart = UserCart.fromJson(json.decode(userCartStr));
      UserShipping? userShipping;
      if (isNotEmpty(userShippingStr)) {
        userShipping = UserShipping.fromJson(json.decode(userShippingStr!));
      }
      return ShippingAddressInfoPage(userCart, userShipping: userShipping);
    });
// endregion

// region Cart
final cartHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final userCartsStr = params[CartPage.kUserCarts]!.first;
      final userCarts = (json.decode(userCartsStr) as List<dynamic>)
          .map((i) => UserCart.fromJson(i))
          .toList();
      return CartPage(userCarts);
    });

final submitCodeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final paymentMethodStr = params[SubmitCodePage.kPaymentMethod]!.first;
      final vcesCorrelationId = params[SubmitCodePage.kVcesCorrelationId]!.first;
      final paymentMethod = PaymentMethod.fromJson(json.decode(paymentMethodStr));
      return SubmitCodePage(paymentMethod, vcesCorrelationId);
    });

final creditCardHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final creditCardActionStr = params[CreditCardPage.kAction]!.first;
      final vcesCorrelationId = params[CreditCardPage.kVcesCorrelationId]!.first;
      final creditCardAction = CreditCardAction.values.firstWhere((v) => v.name == creditCardActionStr);
      return CreditCardPage(creditCardAction, vcesCorrelationId);
    });

final alipayHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final alipayResponseStr = params[AlipayPage.kAlipayResponse]!.first;
      final alipayResponse = AlipayResponse.fromJson(json.decode(alipayResponseStr));
      return AlipayPage(alipayResponse);
    });

final bocAlipayHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final bocAlipayResponseStr = params[BoCAlipayPage.kBoCAlipayResponse]!.first;
      final alipayResponse = BoCAlipayResponse.fromJson(json.decode(bocAlipayResponseStr));
      return BoCAlipayPage(alipayResponse);
    });

final payMeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final payMeResponseStr = params[PayMePage.kPayMeResponse]!.first;
      final payMeResponse = PayMeResponse.fromJson(json.decode(payMeResponseStr));
      return PayMePage(payMeResponse);
    });

final mpgs3DSHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final htmlStr = params[MPGS3DSPage.kMPGS3DSHtml]!.first;
      return MPGS3DSPage(htmlStr);
    });

final vcesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final creditCardNum = params[VCESPage.kCreditCardNum]!.first;
      return VCESPage(creditCardNum);
    });

final newSpuHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final pickupSuggestionsStr = params[NewSpuPage.kPickupSuggestions]!.first;
      final pickupSuggestions = (json.decode(pickupSuggestionsStr) as List<dynamic>)
          .map((i) => PickupSuggestion.fromJson(i))
          .toList();
      return NewSpuPage(pickupSuggestions);
    });
// endregion

// region Media
final imageViewerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final imagesStr = params[ImageViewerPage.kImages]!.first;
      final images = (json.decode(imagesStr) as List<dynamic>).cast<String>();
      final index = int.parse(params[ImageViewerPage.kIndex]?.first ?? '0');
      final heroTag = params[ImageViewerPage.kHeroTag]?.first ?? '';
      return ImageViewerPage(images, index: index, heroTag: heroTag);
    });
// endregion

// region Account
final accountHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const AccountPage();
    });

final profileEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final isAutoFocusBirthdayStr = params[ProfileEditPage.kIsAutoFocusBirthday]?.first;
      bool isAutoFocusBirthday = false;
      if (isAutoFocusBirthdayStr != null) {
        isAutoFocusBirthday = isAutoFocusBirthdayStr.toLowerCase() == 'true';
      }
      return ProfileEditPage(isAutoFocusBirthday);
    });

final paymentMethodHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const PaymentMethodPage();
    });

final nDollarLogsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const NDollarLogsPage();
    });

final pointHistoryHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final index = int.parse(params[PointHistoryPage.kTabIndex]?.first ?? '0');
      return PointHistoryPage(tabIndex: index);
    });

final notificationSettingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const NotificationSettingPage();
    });

final feedbackHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const FeedbackPage();
    });
// endregion

// region Order
final orderHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final tabIndex = int.parse(params[OrderPage.kTabIndex]?.first ?? '0');
      return OrderPage(tabIndex: tabIndex,);
    });

final orderDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final orderId = params[OrderDetailPage.kOrderId]!.first;
      final isCurrentOrderStr = params[OrderDetailPage.kIsCurrentOrder]?.first;
      final showConfettiAnimationStr = params[OrderDetailPage.kShowConfettiAnimation]?.first;
      bool isCurrentOrder = false;
      bool showConfettiAnimation = false;
      if (isCurrentOrderStr != null) {
        isCurrentOrder = isCurrentOrderStr.toLowerCase() == 'true';
      }
      if (showConfettiAnimationStr != null) {
        showConfettiAnimation = showConfettiAnimationStr.toLowerCase() == 'true';
      }
      return OrderDetailPage(orderId, isCurrentOrder: isCurrentOrder, showConfettiAnimation: showConfettiAnimation,);
    });

final intangibleGoodVoucherHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final orderDealId = params[IntangibleGoodVoucherPage.kOrderDealId]!.first;
      return IntangibleGoodVoucherPage(orderDealId);
    });
// endregion

// region Coupon
final couponHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const CouponPage();
    });

final couponListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final isFromCart = params[CouponListPage.kIsFromCart]?.first == "true";
      return CouponListPage(isFromCart: isFromCart);
    });
// endregion

// region Misc
final webViewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final url = params[WebViewPage.kUrl]!.first;
      final title = params[WebViewPage.kTitle]?.first ?? '';
      final showAppBar = params[WebViewPage.kShowAppBar]?.first != "false";
      final usePlatformUserAgent = params[WebViewPage.kUsePlatformUserAgent]?.first != "false";
      // final isTestingJSFunction = params[WebViewPage.kIsTestingJSFunction]?.first != "false";
      return WebViewPage(url,
        title: title,
        showAppBar: showAppBar,
        usePlatformUserAgent: usePlatformUserAgent,
        /*isTestingJSFunction: isTestingJSFunction*/);
    });

final referralHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const ReferralPage();
    });

final pickupCodeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const PickupCodePage();
    });

final notFoundHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const NotFoundPage();
    });

// region Message
// 2023-07-31 task #20272 message hub enhancements
// final messageListHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   return const MessageListPage();
// });

final messageHubHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final index = int.parse(params[MessageHubPage.kTabIndex]?.first ?? '0');
      return MessageHubPage(tabIndex: index,);
    });

final messageDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final messageId = params[MessageDetailPage.kMessageId]!.first;
      return MessageDetailPage(messageId);
    });

final pickupNotificationHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final pickupId = params[PickupNotificationPage.kPickupId]!.first;
      final qrCode= params[PickupNotificationPage.kQrCode]!.first;
      return PickupNotificationPage(pickupId: pickupId, qrCode: qrCode);
    });

final redemptionListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const RedemptionListPage();
    });

final searchHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final keyword = params[SearchPage.kKeyword]?.first ?? "";
      final searchType = params[SearchPage.kSearchType]?.first ?? "";
      return SearchPage(keyword,searchType);
    });

// endregion

final searchResultHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final keyword = params[SearchResultPage.kKeyword]!.first;
      final searchType = params[SearchResultPage.kSearchType]?.first ?? "";
      final isUpdateSuggestionList = params[SearchResultPage.kIsUpdateSuggestionList]?.first != "false";
      return SearchResultPage(keyword,searchType,isUpdateSuggestionList);
    });

final fnBMapHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final tabId = int.parse(params[FnBMapPage.kTabId]?.first ?? '0');
      final isEnableLocationPermission = params[FnBMapPage.kisEnableLocationPermission]?.first == "true";
      return FnBMapPage(tabId: tabId, isEnableLocationPermission: isEnableLocationPermission);
    });

final newPickUpPointSFAddressHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      final userCartStr = params[NewPickUpPointSFAddressPage.kUserCart]!.first;
      final userCart = UserCart.fromJson(json.decode(userCartStr));
      return NewPickUpPointSFAddressPage(userCart);
    });