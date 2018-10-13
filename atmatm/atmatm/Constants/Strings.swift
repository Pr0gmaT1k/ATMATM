// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// closed
  internal static let closed = L10n.tr("Localizable", "closed")
  /// Friday
  internal static let friday = L10n.tr("Localizable", "friday")
  /// Monday
  internal static let monday = L10n.tr("Localizable", "monday")
  /// Saturday
  internal static let saturday = L10n.tr("Localizable", "saturday")
  /// Sunday
  internal static let sunday = L10n.tr("Localizable", "sunday")
  /// Thursday
  internal static let thursday = L10n.tr("Localizable", "thursday")
  /// Tuesday
  internal static let tuesday = L10n.tr("Localizable", "tuesday")
  /// Wednesday
  internal static let wednesday = L10n.tr("Localizable", "wednesday")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
