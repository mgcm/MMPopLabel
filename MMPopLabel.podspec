Pod::Spec.new do |s|
  s.name             = "MMPopLabel"
  s.version          = "0.1.0"
  s.summary          = "MMPopLabel is a tooltip control for iOS, with optional buttons"
  s.description      = <<-DESC
MMPopLabel is a tooltip control for iOS, useful for tutorials.

It supports:

* optional buttons
* appearance proxy for styling
                       DESC
  s.homepage         = "http://github.com/mgcm/MMPopLabel"
  s.screenshots      = "https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-1.png", "https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-2.png", "https://raw.githubusercontent.com/mgcm/MMPopLabel/master/Assets/MMPopLabel-3.png"
  s.license          = 'MIT'
  s.author           = { "mgcm" => "miltonmoura@gmail.com" }
  s.source           = { :git => "https://github.com/mgcm/MMPopLabel.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.m'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
end
