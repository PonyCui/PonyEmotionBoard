
Pod::Spec.new do |s|

  s.name         = "PonyEmotionBoard"
  s.version      = "0.0.1"
  s.summary      = "A short description of PonyEmotionBoard."

  s.description  = <<-DESC
                   A longer description of PonyEmotionBoard in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://EXAMPLE/PonyEmotionBoard"

  s.license      = "MIT"

  s.author             = { "PonyCui" => "cuiminghui@yy.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/PonyGroup/PonyEmotionBoard.git"}

  s.source_files  = "PonyEmotionBoard/Classes","PonyEmotionBoard/Classes/**","PonyEmotionBoard/Classes/**/**","PonyEmotionBoard/Classes/**/**/**"

  s.resources = "PonyEmotionBoard/Resources/*.xcassets", "PonyEmotionBoard/Resources/*.storyboard", "PonyEmotionBoard/Resources/*.plist"

  s.requires_arc = true

  s.dependency "ReactiveCocoa", "2.4.4"

end
