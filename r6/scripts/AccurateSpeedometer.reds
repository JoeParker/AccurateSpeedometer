import AccurateSpeedometer.Config.*

class AccurateSpeedometer {
    public static func finalModifier() -> Float = isMph() ? speedModifier() : speedModifier() * 1.6;
}

// Vehicle HUD (3rd person cam)

@replaceMethod(hudCarController)
protected cb func OnSpeedValueChanged(speedValue: Float) -> Bool {
    speedValue = AbsF(speedValue);
    let multiplier: Float = GameInstance.GetStatsDataSystem(this.m_activeVehicle.GetGame()).GetValueFromCurve(n"vehicle_ui", speedValue, n"speed_to_multiplier");
    inkTextRef.SetText(this.m_SpeedValue, IntToString(RoundMath(speedValue * multiplier * AccurateSpeedometer.finalModifier())));
}

// Vehicle interior display (1st person cam)

@replaceMethod(speedometerLogicController)
public final func OnSpeedValueChanged(speed: Float) -> Void {
    let multiplier: Float;
    if speed < 0.00 {
        inkTextRef.SetText(this.m_speedTextWidget, "0");
    } else {
        multiplier = GameInstance.GetStatsDataSystem(this.m_vehicle.GetGame()).GetValueFromCurve(n"vehicle_ui", speed, n"speed_to_multiplier");
        inkTextRef.SetText(this.m_speedTextWidget, IntToString(RoundMath(speed * multiplier * AccurateSpeedometer.finalModifier())));
    };
}

// Other /cyberpunk/UI/vehicles/...

@replaceMethod(inkMotorcycleHUDGameController)
protected cb func OnSpeedValueChanged(speedValue: Float) -> Bool {
    let animRatio: Float = 0.70;
    let calcSpeedFloat: Float = speedValue * 2.24;
    let calcSpeed: Int32 = RoundMath(calcSpeedFloat * AccurateSpeedometer.finalModifier());
    if speedValue < 0.00 {
        inkTextRef.SetText(this.m_speedTextWidget, "Common-Digits-Zero");
    } else {
        inkTextRef.SetText(this.m_speedTextWidget, IntToString(calcSpeed));
    };
    this.m_lowerSpeedBigL.SetTranslation(new Vector2(calcSpeedFloat * animRatio * -1.00, 0.00));
    this.m_lowerSpeedBigR.SetTranslation(new Vector2(calcSpeedFloat * animRatio, 0.00));
    this.m_lowerSpeedSmallL.SetTranslation(new Vector2(calcSpeedFloat * animRatio * -1.00, 0.00));
    this.m_lowerSpeedSmallR.SetTranslation(new Vector2(calcSpeedFloat * animRatio, 0.00));
    this.m_lowerSpeedFluffL.SetTranslation(new Vector2(calcSpeedFloat * animRatio * -1.20, 0.00));
    this.m_lowerSpeedFluffR.SetTranslation(new Vector2(calcSpeedFloat * animRatio * 1.20, 0.00));
    this.m_hudLowerPart.SetTranslation(new Vector2(0.00, calcSpeedFloat * animRatio * -1.00));
}

@replaceMethod(vehicleInteriorUIGameController)
protected cb func OnSpeedValueChanged(speedValue: Float) -> Bool {
    if speedValue < 0.00 {
        inkTextRef.SetText(this.m_speedTextWidget, "0");
    } else {
        inkTextRef.SetText(this.m_speedTextWidget, IntToString(RoundMath(speedValue * 2.24 * AccurateSpeedometer.finalModifier())));
    };
}