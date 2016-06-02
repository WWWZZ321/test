Pod::Spec.new do |s|

  s.name         = "test"
  s.version      = "1.0.0"
  s.summary      = "test"

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/WWWZZ321/test"
   s.license      = "MIT (example)"
    s.author             = { "WWWZZ321" => "email@address.com" }
    s.source       = { :git => "https://github.com/WWWZZ321/test.git", :tag => "1.0.0" }
  s.ios.deployment_target = '6.0'
  s.requires_arc  = true
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  end
