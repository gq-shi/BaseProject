
Pod::Spec.new do |s|

  s.name         = "BaseProject"
  s.version      = "0.0.1"
  s.summary      = "创建一个baseProgect"

  s.description  = <<-DESC
	初始化OC项目用到的一些base类
                   DESC

  s.homepage     = "https://github.com/smallSmallQiang/BaseProject"
  s.license      = "MIT"
  s.author             = { "gqshi" => "shiguoqiangit@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/smallSmallQiang/BaseProject.git", :tag => "#{s.version}" }
  s.source_files  = "BaseProject/Classes/**/*.{h,m}"

  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
  s.dependency "AFNetworking", "~> 3.1.0"
  s.dependency "ReactiveObjC", '~> 3.1.0'
  s.dependency "Masonry", '~> 1.0.2'
  s.dependency "RTRootNavigationController", '~> 0.6.3'
  s.dependency "YYCache", '~> 1.0.4'
  s.dependency "HYBHelperKit", '~> 0.2.0'
  s.dependency "MJExtension", '~> 3.0.13'
  s.dependency "SVProgressHUD", '~> 2.2.2'
end
