class EndPoints {
  static const String baseUrl = 'https://test.live.com/api/v1/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://test.live.com/';
  static const String apiKey = 'eGvviZ/npgc2Blb4/PSymh1tyb/UIt3aq82W6f+Wn4=';
  static const String topic = 'live';
  static const String logIn = 'auth/login';
  static const String forgetPassword = 'auth/forget-password';
  static const String resetPassword = 'auth/reset-password';
  static const String register = 'auth/register';
  static const String verifyPhone = 'auth/verify_phone';
  static const String getProfile = 'profile/profile';
  static const String getCountries = '/app/countries';
  static const String getBanks = '/app/banks';
  static const String updateProfile = 'profile/update';
  static const String postOffer = 'offer/postOffer';
  static const String listOffers = 'offer/listOffers';
  static const String availableOffers = 'offer/list_available';
  static const String myOffers = 'offer/listOffers';
  static const String viewMyOffers = 'offer/view_my_offer';
  static const String requestDetails = 'offer/view_request_offer';
  static const String offerDetails = 'offer/view_offer';
  static const String followers = 'profile/followers_list';
  static const String addFollower = 'profile/add_follower';
  static const String updateFollowerDetails = 'profile/update_follower';
  static const String deleteFollower = 'profile/delete_follower';
  static const String getContact = 'app/contact';
  static const String getWishList = 'favorites/index';
  static const String postWishList = 'favorites/addOrDelete';
  static const String addOffer = 'offer/request_offer';
  static const String updateRequest = 'offer/request_update';
  static const String userProfile = 'profile';
  static const String getFeedback = 'feedback/list';
  static const String getOfferFeedback = 'offer/feedbacks';
  static const String sendFeedback = 'feedback/feedback';
  static const String report = 'report';
  static const String couponURl = 'client/coupon/check';
  static const String reserve = 'client/reservation/reserve';
  static const String myTrips = 'reservation';
  static const String notifications = 'notification/notification';
  static const String readNotification = 'notification/read';
  static const String deleteNotification = 'notification/delete';
  static const String paymentData = 'app/data';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
