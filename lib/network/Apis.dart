class Apis {

  static const String DEVELOPMENT_BASE_URL = "http://3.7.145.58/app/public/api/";

  static const String BASE_URL = DEVELOPMENT_BASE_URL;
  static const String IMAGE_URL = DEVELOPMENT_BASE_URL;



  static String privacy_url = "http://gc9.scci.co.in/Adminsite/privacy_policy.html";







  static const String SEND_OTP = BASE_URL+"send-otp";
  static const String RE_SEND_OTP = BASE_URL+"resend-otp";
  static const String VERIFY_OTP = BASE_URL+"verify-otp";
  static const String UPDATE_USER_PROFILE = BASE_URL+"update-user-profile";
  static const String GET_USER_PROFILE = BASE_URL+"user-profile";
  static const String GET_PROPERTY_TYPE = BASE_URL+"property-type";
  static const String GET_FURNISHED_STATUS = BASE_URL+"furnished-status";
  static const String GET_STATES = BASE_URL+"states";
  static const String GET_STATE_CITY = BASE_URL+"state-cities";
  static const String GET_FACILITIES = BASE_URL+"facilities";
  static const String ADD_PROPERTY = BASE_URL+"add-property";
  static const String UPDATE_PROPERTY = BASE_URL+"update-property";
  static const String ADD_PROPERTY_IMAGE = BASE_URL+"add-property-image";
  static const String GET_MY_PROPERTY_LIST = BASE_URL+"property-list";
  static const String GET_MY_PROPERTY_DETAIL = BASE_URL+"property-detail";
  static const String GET_SEARCH_HOME = BASE_URL+"dashboard";
  static const String GET_SEARCH_DATA = BASE_URL+"dashboard-search";
  static const String SEND_INTEREST_ON_PROPERTY = BASE_URL+"property-request";
  static const String GET_HOME_SCREEN_DATA = BASE_URL+"home";
  static const String DECLINE_REQUEST = BASE_URL+"decline-property-request";
  static const String DECLINE_INVITE_INTEREST = BASE_URL+"decline-invite-interest";
  static const String REQUEST_DETAIL = BASE_URL+"request-detail";
  static const String INVITE_PROPERTY = BASE_URL+"invite-property";
  static const String INVITE_HISTORY_LIST = BASE_URL+"invite-interest-list";
  static const String ADD_REMOVE_WISH_LIST = BASE_URL+"property-wishlist";
  static const String ADD_ADDRESS = BASE_URL+"add-user-address";
  static const String UPDATE_ADDRESS = BASE_URL+"update-user-address";
  static const String GET_ALL_ADDRESS = BASE_URL+"user-address";
  static const String ADD_ADDRESS_DETAILS = BASE_URL+"add-document-detail";
  static const String UPDATE_ADDRESS_DETAILS = BASE_URL+"update-document-detail";
  static const String ADD_NEGOTIATION_DETAILS = BASE_URL+"add-rent-negotiation";
  static const String UPDATE_NEGOTIATION_DETAILS = BASE_URL+"update-rent-negotiation";
  static const String UPDATE_NEGOTIATION_STATUS = BASE_URL+"rent-negotiation-update-status";
  static const String INIT_RAZOR_PAY_ORDER = BASE_URL+"int-order-razor-pay";
  static const String GET_WALLET_MONEY = BASE_URL+"wallet-money";
  static const String ADD_WALLET_MONEY = BASE_URL+"add-wallet-money";
  static const String ADD_WITNESS = BASE_URL+"add-witness";
  static const String UPDATE_WITNESS = BASE_URL+"update-witness";
  static const String INITIATE_E_SIGN = BASE_URL+"sign-pdf";
  static const String E_SIGN_DETAILS = BASE_URL+"e-sign-detail";
  static const String RESEND_E_SIGN_LINK = BASE_URL+"resend-witness-link";
  static const String GET_NOTIFICATION_LIST = BASE_URL+"notification-list";
  static const String GET_TRANSACTION_LIST = BASE_URL+"transaction-list";
  static const String POKE = BASE_URL+"poke";
  static const String REQUEST_CALLBACK = BASE_URL+"request-callback";
  static const String ADD_BANK_ACCOUNT = BASE_URL+"add-bank-account";
  static const String LINK_BANK_ACCOUNT = BASE_URL+"update-user-account";
  static const String DELETE_BANK_ACCOUNT = BASE_URL+"delete-bank-account";
  static const String GET_BANK_ACCOUNT_LIST = BASE_URL+"bank-account-list";
  static const String GET_TENANT_LIST = BASE_URL+"my-active-tenants";
  static const String ADD_EXTRA_BILL = BASE_URL+"add-extra-bills";
  static const String GET_EXTRA_BILL_LIST = BASE_URL+"extra-bills-list";
  static const String GET_SERVICE_CHARGES = BASE_URL+"service-charges";
  static const String UPDATE_MANDATE_STATUS = BASE_URL+"recurring-pay";
  static const String UPDATE_FIRST_PAYMENT_STATUS = BASE_URL+"first-rent-pay";
  static const String PAY_EXTRA_BILL_TENANT = BASE_URL+"add-extraBills-tenant";
  static const String CREATE_ORDER_EXTRA_BILL_TENANT = BASE_URL+"order-extraBills-tenant";
  static const String UPDATE_BILL_PAY_STATUS = BASE_URL+"update-payment-status-tenant";
  static const String UPDATE_UPCOMING_RENT_PAY_STATUS = BASE_URL+"verify-upcoming-rent-pay";
  static const String GET_UPCOMING_RENTS = BASE_URL+"upcoming-rent-pay";
  static const String ADD_BROKER = BASE_URL+"add-broker";
  static const String REMOVE_BROKER = BASE_URL+"remove-broker";





  static String product_detail = BASE_URL+"/GCPProduct/proddetails.aspx?ProductId=pid&DealerId=did&ProductGroupID=gid";

  static const String API_LOGIN = BASE_URL+"/TrackingServices/Authentication/SendMechanicLoginOTP";
  static const String SUBMIT_QR_CODE = BASE_URL+"/TrackingServices/Tracking/SubmitUnitTrackingIds";
  static const String VERIFY_VEHICLE_NUMBER = BASE_URL+"/TrackingServices/RegCheck/CheckRegistration?VehicleNumber=#VehicleNumber&MechanicID=#MechanicID";
  static const String VIEW_STATEMENT = BASE_URL+"/TrackingServices/Tracking/GetMechanicStatetent";
  static const String API_SUBMIT_OTP = BASE_URL+"/TrackingServices/Authentication/ValidateMechanicOTP";
  static const String API_GET_LANGUAGES = BASE_URL+"/TrackingServices/Tracking/Getlanguages";
  static const String API_UPDATE_PROFILE = BASE_URL+"/TrackingServices/Authentication/UpdateMechanic";
  static const String API_UPDATE_LANGUAGE = BASE_URL+"/TrackingServices/Authentication/UpdateMechanicLanguage?MechanicID=#MechanicID&LanguageID=#LanguageID";
  static const String API_DOWNLOAD_LANGUAGES_TRANSLATION = BASE_URL+"/TrackingServices/Language/";
  static const String API_CHALLENGES = BASE_URL+"/challenges/";
  static const String API_GET_MECHANIC_POINTS = BASE_URL + "/TrackingServices/Tracking/CalculateMechanicPoints";

  static const String API_REDEEM_MECHANIC_POINTS = BASE_URL + "/TrackingServices/Tracking/RedeemMechanicPoints";
  static const String API_COMPLETED_CHALLENGES = BASE_URL+"/TrackingServices/Challenge/GetCompletedMechanicChallanges";
  static const String API_AVAILABLE_CHALLENGES = BASE_URL+"/TrackingServices/Challenge/GetAvailableMechanicChallanges";
  static const String API_ACTIVE_CHALLENGES = BASE_URL+"/TrackingServices/Challenge/GetMechanicChallange";
  static const String API_BOOK_MECHANIC_CHALLENGES = BASE_URL+"/TrackingServices/Challenge/BookMechanicChallange";
  static const String API_UPLOAD_PIC = BASE_URL+"/TrackingServices/Authentication/UploadMechanicImage?MechanicID=#MechanicID";

}

