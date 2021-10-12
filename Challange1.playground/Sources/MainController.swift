import Foundation

public class StoryController {
  
  // Current scene
  var currentPosition = 0
  
  // List of scenes that will be shown
  let storyList: [Dialog] = [
    Dialog(characterImg: "dolomites.jpeg", dialogText: "Dialog...", sceneImg: "giau.jpeg"),
    Dialog(characterImg: "giau.jpeg", dialogText: "Dialog...", sceneImg: "dolomites.jpeg")
  ]
  
  // Get current dialog
  public var currentItem: Dialog {
    get { return self.storyList[currentPosition] }
  }
  
  public func nextDialog() -> Dialog {
    return storyList[currentPosition % storyList.capacity]
  }
  
  public func animateText(animatedText: @escaping (String) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      var buildingDialog = ""
      for char in self.currentItem.dialogText {
        buildingDialog += String(char)
        animatedText(buildingDialog)
        usleep(1000000)
      }
    }
  }
  
  public init() {}
}
