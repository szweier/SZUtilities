Pod::Spec.new do |s|
  s.name             = "SZUtilities"
  s.version          = "0.0.1"
  s.xcconfig         = { 'SWIFT_VERSION' => '3.0' }
  s.summary          = "Utilities to simplify day to day problems"
  s.description      = "A library with customized extensions to simplify your code"
  s.homepage         = "http://www.stevenzweier.com"
  s.license          = 'MIT'
  s.author           = { "Steven Zweier" => "steve.zweier+utilities@me.com" }
  s.source           = { :git => "https://github.com/szweier/SZUtilities.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.subspec 'Movable' do |sp|
    sp.source_files = 'SZUtilities/Classes/Movable'
  end
  s.subspec 'CornerRadius' do |sp|
    sp.source_files = 'SZUtilities/Classes/CornerRadius'
  end
  s.subspec 'ProgressView' do |sp|
    sp.source_files = 'SZUtilities/Classes/ProgressView'
  end
  s.subspec 'Tooltip' do |sp|
    sp.source_files = 'SZUtilities/Classes/Tooltip'
  end
end
