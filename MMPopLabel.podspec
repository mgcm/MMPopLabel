Pod::Spec.new do |s|
  s.name             = "MMPopLabel"
  s.version          = "0.1.0"
  s.summary          = "MMPopLabel is a tooltip control for iOS, with optional buttons"
  s.description      = <<-DESC
                       An optional longer description of MMPopLabel

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://github.com/mgcm/MMPopLabel"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "mgcm" => "miltonmoura@gmail.com" }
  s.source           = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
end
