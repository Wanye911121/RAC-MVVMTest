Pod::Spec.new do |s|
  s.name         = “RACWithMVVM”
  s.version      = “1.0.0”
  s.summary      = “RACWithMVVMTestExample”

  s.homepage     = "https://github.com/MikeZhangpy/RAC-MVVMTest"
  s.license      = 'MIT'
  s.authors      = { ‘MikeZhangpy’ => ‘zhangpy1991@126.com’ }
  s.platform     = :ios, "6.0"
  s.ios.deployment_target = "6.0"
  s.source       = { :git => "https://github.com/MikeZhangpy/RAC-MVVMTest.git", :tag => s.version}
  s.source_files = '"RAC-MVVMTest/*.{h,m}"'
  s.requires_arc = true
  s.dependency 'Masonry', '~> 0.6.2'
  s.dependency 'ReactiveCocoa','~> 4.0.4-alpha-1'
  s.dependency 'Masonry'
  s.dependency 'MBProgressHUD'
  s.dependency 'AFNetworking'
  s.dependency 'MJExtension'
  s.dependency 'pop'
end
