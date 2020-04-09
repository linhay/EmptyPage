Pod::Spec.new do |s|
s.name             = 'EmptyPage'
s.version          = '3.3.1'
s.summary          = 'iOS - 轻量级空白页占位图框架...'

s.homepage         = 'https://github.com/linhay/EmptyPage'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linhay' => 'is.linhay@outlook.com' }
s.source = { :git => 'https://github.com/linhay/EmptyPage.git', :tag => s.version.to_s }

s.swift_version = ['4.0', '4.2', '5.0', '5.1']

s.ios.deployment_target = '8.0'
s.requires_arc = true

s.subspec 'Core' do |ss|
  ss.source_files = 'Sources/Core/*.{swift,h}'
end

s.subspec 'Standard' do |ss|
  ss.source_files = 'Sources/Standard/*.{swift}'
  ss.dependency 'EmptyPage/Core'
end

end

