Pod::Spec.new do |s|
  s.name     = 'Swizzle'
  s.version  = '0.0.3'
  s.license  = { :type => 'MIT' }
  s.homepage = 'https://github.com/inamiy/Swizzle'
  s.authors  = { 'Yasuhiro Inami' => 'inamiy@gmail.com' }
  s.summary  = 'Method-Swizzling for Swift.'
  s.source   = { :git => 'https://github.com/inamiy/Swizzle.git', :tag => "#{s.version}" }
  s.source_files = 'Swizzle/*.{h,swift}'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end
