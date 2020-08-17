

Pod::Spec.new do |s|
    s.name             = 'JBase'
    s.version          = '0.2.0'
    s.summary          = 'A short description of JBase.'
  
  
    s.description      = <<-DESC
  base part of project, contains extensions and other utils
                         DESC
  
    s.homepage         = 'https://github.com/jiazifa/JBase'
    s.license          = { type: 'MIT', file: 'LICENSE' }
    s.author           = { 'jiazifa' => '2332532718@qq.com'}
    s.source           = { git:'https://github.com/jiazifa/JBase.git', tag: s.version.to_s }
  
    s.ios.deployment_target = '11.0'
    
    s.swift_version = '5.1'

    s.source_files = 'source/**/*'

    s.subspec 'Extension' do |ss|
        ss.source_files = 'source/Foundation/*'
        ss.source_files = 'source/UIKit/*'
    end
    
    s.subspec 'CustomUI' do |ss|
        ss.source_files = 'source/CustomUI/*'
    end

    s.frameworks = 'UIKit'
  end
  