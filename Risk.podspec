Pod::Spec.new do |s|
    s.name         = "Risk"
    s.version      = "3.0.3"
    s.summary      = "Checkout Risk package in Swift"
    s.description  = <<-DESC
    Checkout Risk package in Swift.
    This library contains methods to collect and publish device data.
                     DESC
    s.homepage     = "https://github.com/jasurjakhongirov/checkout-risk-sdk-ios.git"
    s.swift_version = "5.0"
    s.license      = "MIT"
    s.author       = { "Checkout.com Integration" => "integration@checkout.com" }
    s.platform     = :ios, "12.0"
    s.source       = { :git => "https://github.com/jasurjakhongirov/checkout-risk-sdk-ios.git", :tag => s.version }
  
    s.source_files = 'Sources/**/*.swift'
    
    s.dependency 'CheckoutEventLoggerKit', '~> 1.2.4'
    s.dependency 'FingerprintPro', '2.3.1'
    
  end
