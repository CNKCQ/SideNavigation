Pod::Spec.new do |s|
  s.name             = 'SideNavigation'
  s.version          = '1.1.3'
  s.swift_version    = '3.2'
  s.summary          = 'A short description of SideNavigation.'
  s.homepage         = 'https://github.com/cnkcq/SideNavigation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cnkcq' => 'chengquan.wang@ele.me' }
  s.source           = { :git => 'https://github.com/cnkcq/SideNavigation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'SideNavigation/Classes/**/*' 
  # s.resource_bundles = {
  #   'SideNavigation' => ['SideNavigation/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
