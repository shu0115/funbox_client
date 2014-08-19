class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # ドリルダウンの遷移を作りたいので EntriesController のインスタンスを作り、UINavigationController の中に入れる
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(EntriesController.new)
    @window.makeKeyAndVisible
    true
  end
end
