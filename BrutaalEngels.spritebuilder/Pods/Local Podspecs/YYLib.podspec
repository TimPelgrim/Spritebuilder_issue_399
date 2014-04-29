Pod::Spec.new do |s|
  s.name         = "YYLib"
  s.version      = '0.1.1'
  s.summary      = "YipYip's private library for iOS."
  s.source       = {
                    :git => "git@bitbucket.org:yipyip/0000-yipyip-software-library.git", 
                    :tag => '0.1.1' 
                  }
  s.description  = <<-DESC
                   A longer description of YYLib in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "http://www.yipyip.nl"
  s.license	     = {:type => 'Commercial'}
  s.author       = { "Tim Pelgrim" => "t.pelgrim@yipyip.nl" }
  s.platform     = :ios, '7.0'
  s.source_files  = 'YYLib/YYLib', 'YYLib/YYlib/**/*.{h,m}'
  s.exclude_files = 'YYlib/Exclude'
  s.library   = 'sqlite3'
  s.requires_arc = true
end
