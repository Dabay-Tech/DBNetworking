Pod::Spec.new do |s|

  s.name         = "DBNetworking"
  s.version      = "1.0.5"
  s.summary      = "Dabay tech : DBNetworking is a high level request util based on AFNetworking."
  s.homepage     = "https://github.com/Dabay-Tech/DBNetworking"
  s.license      = "MIT"
  s.author       = { "Tao Fei" => "taofei0610@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Dabay-Tech/DBNetworking.git", :tag => s.version.to_s}
  s.source_files = "DBNetworking/**/*.{h,m}"
  s.frameworks   = "CFNetwork",'Security'
  s.requires_arc = true
  s.dependency  "AFNetworking", "~> 3.1.0"
  s.dependency  "DBProgressHUD"

end
