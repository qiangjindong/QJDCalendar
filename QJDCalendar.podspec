Pod::Spec.new do |s|
s.name         = 'QJDCalendar'
s.version      = '0.0.5s'
s.summary      = '一款简单的日历的视图控件，支持"周历"和"月历"切换'
s.homepage     = 'https://github.com/coderqjd/QJDCalendar'
s.license      = 'MIT'
s.authors      = { 'coderqjd' => 'qiangjindong@163.com' }
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/coderqjd/QJDCalendar.git', :tag => s.version}
s.source_files = 'QJDCalendar/**/*.{h,m}'
s.resource     = 'QJDCalendar/QJDCalendar.bundle'
s.requires_arc = true
end
