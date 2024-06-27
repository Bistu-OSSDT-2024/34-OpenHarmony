@Component
export default struct CustomEdiDialog{

  @Link editContent : string
  onClose: ()=>void
  onCreate: ()=>void

  build() {
    Stack(){
      //蒙层
      Rect()
        .width('100%')
        .height('100%')
        .fill('rgba(0,0,0,0.4)')
        .onClick(()=>{
          this.onClose()
        })

      // 编辑卡片
      Column(){

        // 文本输入
        Column(){
          TextArea({
            placeholder:'请输入笔记',
            text:this.editContent
          })
            .onChange((value:string)=>{
              this.editContent = value

            })
            .height('100%')
        }

          .height('70%')
        .margin({bottom:20})
          .padding(20)

        //按钮
        Row(){
          // 返回
          Column(){
            Image($r('app.media.back'))
              .width(24)
          }
          .backgroundColor('#BFA290')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(()=>{
            this.onClose()
          })

          // 保存

          Column(){
            Image($r('app.media.save'))
              .width(24)
          }
          .backgroundColor('#9E7F6B')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(()=>{
            this.onCreate
          })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

      }
      .width('100%')
      .height('50%')
      .borderRadius({topLeft:16,topRight:16})
      .backgroundColor('#F0D9B8')

    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)

  }
}

@Preview
@Component
struct CustomEdiDialogPreview{
  @State editContent : string = ''

  build() {
    CustomEdiDialog({editContent:$ediContent})
  }
}