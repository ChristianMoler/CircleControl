# CircleControl
<p align="center"> 
<img src="https://image.ibb.co/bNWjfo/Simulator_Screen_Shot_i_Phone_8_Plus_2018_05_25_at_18_15_31.png">
</p>

[![Language](https://img.shields.io/github/languages/top/ChristianMoler/CircleControl.svg?colorB=ff672f&style=flat-square)](https://cocoapods.org/pods/CircleControl)
[![Version](https://img.shields.io/cocoapods/v/CircleControl.svg?colorB=ff672f&style=flat-square)](https://cocoapods.org/pods/CircleControl)
[![License](https://img.shields.io/cocoapods/l/CircleControl.svg?colorB=ff672f&style=flat-square)](https://cocoapods.org/pods/CircleControl)
[![Platform](https://img.shields.io/cocoapods/p/CircleControl.svg?colorB=ff672f&style=flat-square)](https://cocoapods.org/pods/CircleControl)

Circle control is customizable via interface builder or code. You can change the start, minimum, final value. You can also adjust the step and rate of change of the value. AND YOU CAN CHANGE CONTROLL COLOR !!! So it's amazing , it's future .

## Getting Started

1. Add a view to the storyboard
2. Set constraints
3. Configurate using IB
4. Implement the protocol CircleControlDelegate or set closure valueDidChanged or use action-target

## Installation

CircleControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CircleControl'
```

#### IMPORTANT

Please add 

```
post_install do |installer|
installer.pods_project.build_configurations.each do |config|
config.build_settings.delete('CODE_SIGNING_ALLOWED')
config.build_settings.delete('CODE_SIGNING_REQUIRED')
end
end
```
in your podfile

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

ChristianMoler, christianmoler94@gmail.com

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/ChristianMoler/SlideTo/blob/master/LICENSE) file for details
