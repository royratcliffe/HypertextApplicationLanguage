Pod::Spec.new do |spec|
  spec.name = 'HypertextApplicationLanguage'
  spec.version = '0.2.1'
  spec.summary = 'Swift framework for Hypertext Application Language'
  spec.description = <<-DESCRIPTION
  What HTML does for web browsers, HAL does for applications.
  DESCRIPTION
  spec.homepage = 'https://github.com/royratcliffe/HypertextApplicationLanguage'
  spec.license = { type: 'MIT', file: 'MIT-LICENSE.txt' }
  spec.author = { 'Roy Ratcliffe' => 'roy@pioneeringsoftware.co.uk' }
  spec.source = {
    git: 'https://github.com/royratcliffe/HypertextApplicationLanguage.git',
    tag: spec.version.to_s }
  spec.source_files = 'Sources/**/*.{swift,h}'
  spec.platform = :ios, '9.0'
  spec.requires_arc = true
end
