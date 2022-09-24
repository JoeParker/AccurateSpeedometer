module AccurateSpeedometer.Config

// Set to 'false' to change from mph to kph
public static func isMph() -> Bool = true;

// Adjust the actual speed modifier (only affects displayed speed)
public static func speedModifier() -> Float = 0.52;
