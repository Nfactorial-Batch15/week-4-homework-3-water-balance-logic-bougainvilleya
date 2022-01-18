import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
            print("tap")
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(MyColor.electricBlue)
                    .frame(height: 60)
                
                Text(title)
                    .font(Font.system(size: 22, weight:.semibold))
                    .foregroundColor(.white)
            }
        }
    }
}
