Pod::Spec.new do |s|
s.name             = 'LHEmptyPage'
s.version          = '2.1.0'
s.summary          = 'iOS - 轻量级空白页占位图框架...'

s.homepage         = 'https://github.com/linhay/EmptyPage'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linhay' => 'is.linhay@outlook.com' }
s.source = { :git => 'https://github.com/linhay/EmptyPage.git', :tag => s.version.to_s }

s.swift_version = '4.0'
s.ios.deployment_target = '8.0'
s.requires_arc = true

s.subspec 'Core' do |ss|
  ss.source_files = 'Sources/OC-Core/*.{h,m}'
end

s.subspec 'Standard' do |ss|
  ss.source_files = 'Sources/OC-Standard/*.{h,m}'
  ss.dependency 'LHEmptyPage/Core'
end

end

