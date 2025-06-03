enum AppRoute {
  splash(path: "/splash"),
  onboarding(path: "/onboarding"),
  customizeCategory(path: "/customizeCategory"),
  auth(path: "/auth"),
  signIn(path: "/signIn"),
  signUp(path: "/signUp"),
  appView(path: "/appView"),
  home(path: "/home"),
  post(path: "/post"),
  chat(path: "/chat"),
  search(path: "/search"),
  profile(path: "/profile"),
  updateProfile(path: "/profile/update"),
  setting(path: "/setting"),
  savedPost(path: "/savedPost"),
  personal(path: "/personal"),
  notification(path: "/notification"),
  group(path: "/group"),
  createGroup(path: "/createGroup"),
  updateGroup(path: "/updateGroup"),
  inviteFriendGroup(path: "/inviteFriendGroup"),
  friends(path: "/friends"),
  friendInvitation(path: "/friendInvitation");

  final String path;

  const AppRoute({required this.path});
}
