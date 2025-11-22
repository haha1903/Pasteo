import Cocoa

class About {
  private var credits: NSMutableAttributedString {
    let creditsText = NSMutableAttributedString(string: "",
                                            attributes: [NSAttributedString.Key.foregroundColor: NSColor.labelColor])

    let appCredits = NSAttributedString(
      string: "Based on Maccy by Alexey Rodionov\nEnhanced by Hai Chang",
      attributes: [NSAttributedString.Key.foregroundColor: NSColor.labelColor]
    )

    let links = NSMutableAttributedString(string: "GitHub",
                                         attributes: [NSAttributedString.Key.foregroundColor: NSColor.labelColor])
    links.addAttribute(.link, value: "https://github.com/haha1903/Pasteo", range: NSRange(location: 0, length: 6))

    creditsText.append(links)
    creditsText.append(NSAttributedString(string: "\n\n"))
    creditsText.append(appCredits)
    creditsText.setAlignment(.center, range: NSRange(location: 0, length: creditsText.length))
    return creditsText
  }

  @objc
  func openAbout(_ sender: NSMenuItem?) {
    NSApp.activate(ignoringOtherApps: true)
    NSApp.orderFrontStandardAboutPanel(options: [NSApplication.AboutPanelOptionKey.credits: credits])
  }
}
