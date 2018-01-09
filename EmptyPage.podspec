Pod::Spec.new do |s|
s.name             = 'EmptyPage'
s.version          = '0.1.0'
s.summary          = '空白页占位'


s.homepage         = 'https://github.com/bigL055/EmptyPage'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linhey' => 'linheyhan.linhey@outlook.com' }
s.source = { :git => 'https://github.com/bigL055/EmptyPage.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = ["Sources/*/**","Sources/*/*/**","Sources/**"]

s.public_header_files = ["Sources/EmptyPage.h"]
s.requires_arc = true

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end

