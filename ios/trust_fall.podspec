#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'trust_fall'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for detecting the trust fall of the device(Jailbroken, root, emulator and mock location detection).'
  s.description      = <<-DESC
A Flutter plugin for detecting the trust fall of the device(Jailbroken, root, emulator and mock location detection).
                       DESC
  s.homepage         = 'https://www.neatcommerce.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Neat' => 'kito@neatcommerce.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '9.0'
end

