import CustomTitle from '../component/custom title'
import CustomEdiDialog from '../component/CustomEdiDialog'

@Entry
@Component
struct Index {

  // todo 排序图标切换 @state if 条件渲染
  @State @Watch('onOrderChange') order:boolean = true

  // 新建内容
  @State editContent:string = ''

  // todo 排序状态变化事件监听 @Watch
  onOrderChange(){
    this.list = '降序排列'
  }

  @State list : string = '顺序排列'

  // todo 自定义弹窗 Rect
  @State isEditDialogShow : boolean = false

onClose = ()=>{
    this.isEditDialogShow = false
}


  build() {
    Stack(){
      // 背景图片
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)


      // 页面主体
      Column(){
        // 标题栏
        CustomTitle({
          order:$order,
          isEditDialogShow:$isEditDialogShow
        })

        Divider()
          .color('#604637')


        // 搜索框

        // 笔记列表
        Text(this.list)
          .fontSize(40)

      }
      .width('100%')
      .height('100%')

      // 新增弹窗
      if (this.isEditDialogShow){
        CustomEdiDialog({editContent:$editContent,onClose:this.onClose})
      }




    // 编辑弹窗


    }
    .width('100%')
    .height('100%')
  }
}