Pod::Spec.new do |s|
s.name             = 'EmptyPage'
s.version          = '1.1.0'
s.summary          = '空白页占位'


s.homepage         = 'https://github.com/bigL055/EmptyPage'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linhey' => 'linheyhan.linhey@outlook.com' }
s.source = { :git => 'https://github.com/bigL055/EmptyPage.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.subspec 'Core' do |ss|
ss.source_files = 'Sources/**'
end

s.subspec 'Resources' do |ss|
ss.source_files = 'Resources/**'
ss.dependency 'EmptyPage/Core'
end

s.requires_arc = true
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end

