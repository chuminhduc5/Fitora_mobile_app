enum AppRoute {
  splash(path: "/splash"),
  signIn(path: "/signIn"),
  signUp(path: "/signUp"),
  appView(path: "/appView"),
  home(path: "/home"),
  post(path: "/post"),
  chat(path: "/chat"),
  profile(path: "/profile"),
  personal(path: "/personal");

  final String path;

  const AppRoute({required this.path});
}
