import Foundation

public class StoryController {
  
  // Current scene
  private var currentPosition = 0
  
  // Check if the animation has finished
  private var isAnimating = false
  
  // List of scenes that will be shown
  let storyList: [Dialog] = [
    Dialog(sceneImg: "scene_of_crime.png", characterImg: "morty.png", dialogText: "Sed ut perspiciatis "),
    Dialog(sceneImg: "giau.jpeg", characterImg: "morty.png", dialogText: "Dialog..."),
    Dialog(sceneImg: "scene_of_crime.png", characterImg: "morty.png", dialogText: "Sed ut perspiciatis"),
    Dialog(sceneImg: "scene_of_crime.png", characterImg: "morty.png", dialogText: "Mr. Moriarty, welcome..."),
]
  
  // Get current dialog
  public var currentItem: Dialog {
    get { return self.storyList[currentPosition] }
  }
  
  public func nextDialog(isAnimating: (Bool) -> Void) {
    if self.isAnimating {
      isAnimating(true)
      return
    }
    if currentPosition < storyList.capacity - 1 { currentPosition += 1 }
    isAnimating(false)
  
    print("current position: \(currentPosition)")
    print("image name: \(currentItem.sceneImg)")
  }
  
  public func animateText(
    animatedText: @escaping (String) -> Void,
    onStartAnimating: @escaping () -> Void,
    onFinishedAnimation: @escaping (String) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      self.isAnimating = true
      var buildingDialog = ""
      onStartAnimating()
      for char in self.currentItem.dialogText {
        buildingDialog += String(char)
        animatedText(buildingDialog)
        usleep(100000)
      }
      onFinishedAnimation(buildingDialog)
      self.isAnimating = false
    }
  }
  
  public init() {}
}
