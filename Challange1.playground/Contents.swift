//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport
import Darwin

struct ContentView: View {

  private var controller = StoryController()
  @State private var dialogTxt = ""
  @State private var backgroungImg: String
  @State private var characterImg: String
  @State private var buttonText = "See the next scene"
  
  init() {
    backgroungImg = controller.currentItem.sceneImg
    characterImg = controller.currentItem.characterImg
  }
    
  var body: some View {
    ZStack {
      Image(uiImage: UIImage(named: backgroungImg)!)
            .resizable()
            .frame(width: 750, height: 750)
      HStack {
        Image(uiImage: UIImage(named: characterImg)!)
              .resizable()
              .frame(width: 120, height: 130)
              .offset(x: -55, y: 0)
        Text("\(dialogTxt)")
            .bold()
            .kerning(1.5)
            .lineSpacing(4.0)
            .font(.footnote)
            .frame(width: 400, height: 210)
            .onAppear {
              startTextAnimation()
            }
      }.frame(maxHeight: .infinity, alignment: .bottom)
      Button(action: {
        controller.nextDialog(isAnimating: { isAnimating in
          if !isAnimating {
            startTextAnimation()
          }
        })
        backgroungImg = controller.currentItem.sceneImg
        characterImg = controller.currentItem.characterImg
        dialogTxt = ""

//        print("character img: \(characterImg)")
      }) {
        Text(buttonText)
          .foregroundColor(.white)
          .frame(width: 350, height: 210)
          .offset(x: 65)
      }.frame(maxHeight: .infinity, alignment: .bottom)
    }
  }
  
  func startTextAnimation() {
    controller.animateText(animatedText: { text in
      dialogTxt = text
    }, onStartAnimating: {
//      print("start animating")
      buttonText = ""
    }, onFinishedAnimation: { text in
//      print("stop animating")
      usleep(1100000)
      buttonText = "Go to the next scene"
      dialogTxt = ""
    })
  }
}

// Show the view
PlaygroundPage.current.setLiveView(
    ContentView().frame(width: 750, height: 750)
)
