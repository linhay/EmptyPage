Pod::Spec.new do |s|
    s.name             = 'EmptyPage'
    s.version          = '4.0.0'
    s.summary          = 'iOS - 轻量级空白页占位图框架...'

    s.homepage         = 'https://github.com/linhay/EmptyPage'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'linhay' => 'is.linhay@outlook.com' }
    s.source = { :git => 'https://github.com/linhay/EmptyPage.git', :tag => s.version.to_s }

    s.swift_version = ['4.0', '4.2', '5.0', '5.1']

    s.ios.deployment_target = '9.0'
    s.requires_arc = true

    s.subspec 'core' do |sp|
        sp.source_files = ['Sources/Core/*.{h,swift}', 'Sources/Core/**/*.{h,swift}']
    end

    s.subspec 'standard' do |sp|
        sp.dependency 'EmptyPage/core'
        sp.source_files = 'Sources/Standard/class/*.{swift}'
    end

end

