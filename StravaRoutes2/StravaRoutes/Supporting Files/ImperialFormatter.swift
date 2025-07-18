import Foundation

struct ImperialFormatter {
    /// Formats meters into miles
    /// - Parameter rawMeters: The number of meters to be converted
    /// - Returns: A string representing the distance in miles, localized to the system's current locale
    static func string(forDistance rawMeters: Double) -> String {
        distanceFormatter.string(from: metersToMiles(rawMeters))
    }

    /// Formats meters into feet
    /// - Parameter rawMeters: The number of meters to be converted
    /// - Returns: A string representing the elevation in feet, localized to the system's current locale
    static func string(forElevation rawMeters: Double) -> String {
        elevationFormatter.string(from: metersToFeet(rawMeters))
    }
}

private func measurement(meters: Double) -> Measurement<UnitLength> {
    .init(value: meters, unit: .meters)
}

private let feetConversion = convertMeasurement(to: UnitLength.feet)
private let milesConversion = convertMeasurement(to: UnitLength.miles)

private let metersToFeet = compose(measurement(meters:), feetConversion)
private let metersToMiles = compose(measurement(meters:), milesConversion)

private let distanceFormatter: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitOptions = [.providedUnit]
    formatter.numberFormatter.maximumFractionDigits = 1
    return formatter
}()

private let elevationFormatter: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.unitOptions = [.providedUnit]
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter
}()

private func convertMeasurement<UnitType: Dimension>(
    to unit: UnitType
) -> (Measurement<UnitType>) -> Measurement<UnitType> {
    { measurement in
        measurement.converted(to: unit)
    }
}

private func compose<A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> ((A) -> C) {
    { a in
        g(f(a))
    }
}
