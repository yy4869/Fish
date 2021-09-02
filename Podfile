platform :ios, '10.0'

#use_modular_headers!

pod 'RxSwift', '5.1.0'
pod 'RxCocoa', '5.1.0'
pod 'SnapKit', '~> 4.0.0'
pod 'Reveal-SDK', '~> 4.0'
pod 'SDWebImage', '~> 5.9'
pod 'SCRAttributedStringBuilder', '~> 1.0'

pod 'CardParts', :path => '../CardParts'
#pod 'MLeaksFinder', :configuration => ['DEBUG']
#pod 'FBRetainCycleDetector', :configuration => ['DEBUG']
pod 'TTTAttributedLabel'
pod 'Masonry', '1.1.0'

ENV['FAKELIVE'] = '1'

if ENV['FAKELIVE'] == '1'
    puts 'FAKELIVE true'
else
    puts 'FAKELIVE false'
end

target 'Fish' do
  use_frameworks!
  
end
