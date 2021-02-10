# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

source 'https://github.com/dediprakasa/apod-core-podspec'
 
use_frameworks!
 
workspace 'ModularizedApod'
 
target 'Apod' do
# Pods for App
 pod 'Core'
end


target 'Weekly' do
project './Modules/Weekly/Weekly'
 pod 'Core'
end

target 'ApodDetail' do
project './Modules/ApodDetail/ApodDetail'
pod 'Core'
 
end