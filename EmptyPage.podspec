Pod::Spec.new do |s|
s.name             = 'EmptyPage'
s.version          = '1.1.0'
s.summary          = 'iOS - 轻量级空白页占位图框架...'


s.homepage         = 'https://github.com/linhey055/EmptyPage'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linhey' => 'linheyhan.linhey@outlook.com' }
s.source = { :git => 'https://github.com/bigl055/EmptyPage.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.subspec 'Core' do |ss|
ss.source_files = 'Sources/**'
end

s.subspec 'Standard' do |ss|
ss.source_files = 'Standard/**'
ss.dependency 'EmptyPage/Core'
end

s.subspec 'Spec' do |ss|
ss.source_files = 'Spec/**'
ss.dependency 'EmptyPage/Standard'
end

s.requires_arc = true
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end

