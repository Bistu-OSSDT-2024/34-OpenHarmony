@Component
export default struct CustomTitle{

@Link  order:boolean
@Link  isEditDialogShow:boolean


  // todo 重用样式 @Styles
  @Styles titleButtonStyle(){
    .width(56)
    .height(32)
    .borderColor('#604637')
    .borderWidth(1)
    .borderRadius(4)
  }

  build() {

    Row(){
      //排序
      Column(){
        if(this.order){
          Image($r('app.media.up'))
            .width(16)
        }else {
          Image($r('app.media.down'))
            .width(16)
        }
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({left:20})
      .onClick(()=>{
        this.order = ! this.order
      })

      Blank()
      //标题
      Text('Memo')
        .fontSize(24)
        .fontColor('#FFFEFC')
        .fontWeight('600')

      Blank()
      // 新建笔记
      Column(){
        Image($r('app.media.edit'))
          .width(16)
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({right:20})
      .onClick(()=>{
        this.isEditDialogShow = true
      })



    }
    .width('100%')
    .height(60)
    .linearGradient({
      direction:GradientDirection.Bottom ,
      colors:[['#7B6558',0.5],['#725A4E',1]]
    })
    .shadow({
      radius:10,
      color:'rgba(0,0,0,0.3)',
      offsetX:0,
      offsetY:10
    })
  }
}

@Preview
@Component
struct CustomTitlePreview{
  @State  order:boolean = false
  @State  isEditDialogShow:boolean = false

  build() {
    CustomTitle({order:$order,isEditDialogShow:$isEditDialogShow})
  }

}
