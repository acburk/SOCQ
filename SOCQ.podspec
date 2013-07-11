Pod::Spec.new do |s|
  s.name         = "SOCQ"
  s.version      = "0.0.1"
  s.summary      = "Syntax for Objective-C Queries."
  s.homepage     = "https://github.com/acburk/SOCQ"
  s.license      = 'MIT'
  s.license      = { :type => 'MIT', :file => 'MIT-LICENSE.txt' }
# s.author       = { "acburk" => "email@address.com" }
  s.author       = "acburk"
# s.source       = { :git => "https://github.com/acburk/SOCQ.git", :tag => s.version.to_s }
  s.source       = { :git => "https://github.com/acburk/SOCQ.git", :commit => "4c52eb04745a95ab50f88ef5660177016212ed06" }
  s.platform     = :ios, '5.0'
  s.source_files = 'SOCQ'
  s.requires_arc = true
end
