import 'package:fluro/fluro.dart';
import 'package:neigbuy_flutter_app/ui/navigation/router_handler.dart';

class Routes {
  static const String root = "/";

  // Landing
  static const String kSplash = "/splash";
  static const String kPhoneInput = "/phoneInput";
  static const String kPasswordLogin = "/passwordLogin";
  static const String kPhoneVerificationCode = "/phoneVerificationCode";
  static const String kResetPassword = "/resetPassword";

  // Main
  static const String kMain = "/main";
  static const String kDealDetail = "/dealDetail";

  // Carts
  static const String kCart = "/cart";
  static const String kSubmitCode = "/submitCode";
  static const String kCreditCard = "/creditCard";
  static const String kAlipay = "/alipay";
  static const String kBoCAlipay = "/bocAlipay";
  static const String kPayMe = "/payMe";
  static const String kNewSpu = "/newSpu";
  static const String kNewPickUpPointSFAddress = "/newPickUpPointSFAddress";
  static const String kMPGS3DS = "/mpgs3DS";
  static const String kVCES = "/VCES";

  // Shipping
  static const String kAddShipping = "/addShipping";
  static const String kShippingAddressInfo = "/shippingAddressInfo";

  // Media
  static const String kImageViewer = "/imageViewer";

  // Account
  static const String kAccount = "/account";
  static const String kProfileEdit = "/profileEdit";
  static const String kPaymentMethod = "/paymentMethod";
  static const String kNotificationSetting = "/notificationSetting";
  static const String kFeedback = "/feedback";
  static const String kNDollarLogs = "/nDollarLogs";
  static const String kPointHistory = "/pointHistory";

  // Order
  static const String kOrder = "/order";
  static const String kOrderDetail = "/orderDetail";
  static const String kIntangibleGoodVoucher = "/intangibleGoodVoucher";

  // Coupon
  static const String kCoupon = "/coupon";
  static const String kCouponList = "/couponList";

  // Message
  // 2023-07-31 task #20272 message hub enhancements
  // static const String kMessageList = "/messageList";
  static const String kMessageHub = "/messageHub";
  static const String kMessageDetail = "/messageDetail";

  // Pickup Notification(open from SMS deep link only)
  static const String kPickupNotification = "/pickupNotification";

  // Misc
  static const String kWebView = "/webView";
  static const String kReferral = "/referral";
  static const String kPickupCode = "/pickupCode";
  static const String kCooperation = "/cooperation";
  static const String kNotFound = "/notFound";

  // Redemption
  static const String kRedemptionList = "/redemptionList";

  // Search
  static const String kSearch = "/search";
  static const String kSearchResult = "/searchResult";

  // FnB
  static const String kFnBMapPage = "/fnBMap";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = unknownHandler;

    // Landing
    router.define(kSplash, handler: splashHandler, transitionType: TransitionType.material);
    router.define(kPhoneInput, handler: phoneInputHandler, transitionType: TransitionType.inFromBottom);
    router.define(kPasswordLogin, handler: passwordLoginHandler, transitionType: TransitionType.material);
    router.define(kPhoneVerificationCode, handler: phoneVerificationCodeHandler, transitionType: TransitionType.material);
    router.define(kResetPassword, handler: resetPasswordHandler, transitionType: TransitionType.material);

    // Main
    router.define(kMain, handler: mainHandler, transitionType: TransitionType.fadeIn);
    router.define(kDealDetail, handler: dealDetailHandler, transitionType: TransitionType.material);

    // Cart
    router.define(kCart, handler: cartHandler, transitionType: TransitionType.material);
    router.define(kSubmitCode, handler: submitCodeHandler, transitionType: TransitionType.material);
    router.define(kCreditCard, handler: creditCardHandler, transitionType: TransitionType.material);
    router.define(kAlipay, handler: alipayHandler, transitionType: TransitionType.material);
    router.define(kBoCAlipay, handler: bocAlipayHandler, transitionType: TransitionType.material);
    router.define(kPayMe, handler: payMeHandler, transitionType: TransitionType.material);
    router.define(kNewSpu, handler: newSpuHandler, transitionType: TransitionType.material);
    router.define(kMPGS3DS, handler: mpgs3DSHandler, transitionType: TransitionType.material);
    router.define(kVCES, handler: vcesHandler, transitionType: TransitionType.material);

    // Shipping
    router.define(kAddShipping, handler: addShippingHandler, transitionType: TransitionType.material);
    router.define(kShippingAddressInfo, handler: shippingAddressInfoHandler, transitionType: TransitionType.material);

    // Media
    router.define(kImageViewer, handler: imageViewerHandler, transitionType: TransitionType.material);

    // Account
    router.define(kAccount, handler: accountHandler, transitionType: TransitionType.material);
    router.define(kProfileEdit, handler: profileEditHandler, transitionType: TransitionType.material);
    router.define(kPaymentMethod, handler: paymentMethodHandler, transitionType: TransitionType.material);
    router.define(kNotificationSetting, handler: notificationSettingHandler, transitionType: TransitionType.material);
    router.define(kFeedback, handler: feedbackHandler, transitionType: TransitionType.material);
    router.define(kNDollarLogs, handler: nDollarLogsHandler, transitionType: TransitionType.material);
    router.define(kPointHistory, handler: pointHistoryHandler, transitionType: TransitionType.material);

    // Order
    router.define(kOrder, handler: orderHandler, transitionType: TransitionType.material);
    router.define(kOrderDetail, handler: orderDetailHandler, transitionType: TransitionType.material);
    router.define(kIntangibleGoodVoucher, handler: intangibleGoodVoucherHandler, transitionType: TransitionType.material);

    // Coupon
    router.define(kCoupon, handler: couponHandler, transitionType: TransitionType.material);
    router.define(kCouponList, handler: couponListHandler, transitionType: TransitionType.material);

    // Message
    // 2023-07-31 task #20272 message hub enhancements
    // router.define(kMessageList, handler: messageListHandler, transitionType: TransitionType.material);
    router.define(kMessageHub, handler: messageHubHandler, transitionType: TransitionType.material);
    router.define(kMessageDetail, handler: messageDetailHandler, transitionType: TransitionType.material);

    // Pickup Notification(open from SMS deep link only)
    router.define(kPickupNotification, handler: pickupNotificationHandler, transitionType: TransitionType.material);

    // Misc
    router.define(kWebView, handler: webViewHandler, transitionType: TransitionType.material);
    router.define(kReferral, handler: referralHandler, transitionType: TransitionType.material);
    router.define(kPickupCode, handler: pickupCodeHandler, transitionType: TransitionType.material);
    router.define(kNotFound, handler: notFoundHandler, transitionType: TransitionType.material);

    // Redemption
    router.define(kRedemptionList, handler: redemptionListHandler, transitionType: TransitionType.material);

    // Search
    router.define(kSearch, handler: searchHandler, transitionType: TransitionType.inFromBottom);
    router.define(kSearchResult, handler: searchResultHandler, transitionType: TransitionType.none);

    router.define(kFnBMapPage, handler: fnBMapHandler, transitionType: TransitionType.none);
    router.define(kNewPickUpPointSFAddress, handler: newPickUpPointSFAddressHandler, transitionType: TransitionType.none);
  }
}