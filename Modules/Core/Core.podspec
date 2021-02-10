Pod::Spec.new do |s|
 
s.platform = :ios
s.ios.deployment_target = '14.0'
s.name = "Core"
s.summary = "Apod Core.framework for modularization"
s.requires_arc = true
 
s.version = "1.0.0"
 
s.license = { :type => "MIT", :file => "LICENSE" }
 
s.author = { "Dedi Prakasa" => "dedprakasa@gmail.com" }
 
s.homepage = "https://github.com/dediprakasa/apod-core"
 
s.source = { :git => "https://github.com/dediprakasa/apod-core.git", 
:tag => "#{s.version}" }
 
s.framework = "SwiftUI"
 
s.source_files = "Core/**/*.{swift}"
 
s.swift_version = "5.1"
 
end