import CustomEditDialog from '../component/CustomEditDialog'
import CustomSearch from '../component/CustomSearch'
import CustomTitle from '../component/CustomTitle'
import MemoItem from '../component/Memoltem'
import MemoModel from '../model/MemoModel'


@Entry
@Component
struct Index {
  saveMemo: (() => void) | undefined
  deleteMemo: (() => void) | undefined
  // 缓存的原始数组
  originMemoList: MemoModel[] = []
  // 页面中展示的memo列表
  @State memoList: MemoModel[] = []
  // 是否展示新建memo自定义弹窗
  @State isAddDialogShow: boolean = false
  // 新建暂存内容
  @State addContent: string = ''
  // 是否展示编辑笔记自定义弹窗
  @State isEditDialogShow: boolean = false
  // 编辑弹窗文本输入的暂存内容
  @State editContent: string = ''
  // 当前编辑的memo索引
  editingMemoIndex: number = -1
  // 数据库初始化

  // 点击笔记时的方法
  clickMemo = (memo: MemoModel) => {
    for (let i = 0; i < this.originMemoList.length; i++) {
      this.originMemoList[i].id = memo.id
      this.editingMemoIndex = i
      this.isEditDialogShow = true
      this.editContent = memo.content
    }
  }
  closeDialog = () => {
    this.isAddDialogShow = false
    this.addContent = ''
    this.isEditDialogShow = false
    this.editContent = ''
    this.editingMemoIndex = -1
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.originMemoList = []
    this.memoList = []
    this.order = false
    this.keywords = ''
    this.isAddDialogShow = false
    this.isEditDialogShow = false
    this.addContent = ''
    this.editingMemoIndex = -1
    this.editContent = ''


  }

  // 排序状态
  @State @Watch('refreshByOrder') order: boolean = true

  // 排序状态变化事件监听函数
  refreshByOrder() {
    let orderList: MemoModel[] = this.memoList
    const length = orderList.length
    for (let i = 0; i < length - 1; i++) {
      for (let j = 0; j < length - i - 1; j++) {
        const timeA = orderList[j].updateTime
        const timeB = orderList[j+1].updateTime

        if ((timeA > timeB && this.order) || (timeA < timeB && !this.order)) {
          const temp = orderList[j]
          orderList[j] = orderList[j+1]
          orderList[j+1] = temp
        }
      }
    }
    this.memoList = orderList
  }

  // 搜索关键词
  @State @Watch('onKeywordsChange') keywords: string = ''
  // 清空搜索关键词的方法
  cleanKeywords = () => {
    this.keywords = ''
  }

  // 监听搜索关键词的过滤方法
  onKeywordsChange() {
    if (this.keywords.length === 0) {
      this.memoList = this.originMemoList
      this.refreshByOrder()
    } else {
      let resultList: MemoModel[] = []

      for (const memoItem of this.originMemoList) {
        if (memoItem.content.includes(this.keywords)) {
          resultList.push(memoItem)
        }
      }
      this.memoList = resultList
    }
  }

  build() {
    Stack() {
      // 背景图片
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 主体页面
      Column() {
        // 标题栏
        CustomTitle({
          order: $order,
          isAddDialogShow: $isAddDialogShow
        })

        Divider()
          .color('#604637')

        // 搜索框
        CustomSearch({ keywords: $keywords, cleanKeywords: this.cleanKeywords })

        // 笔记列表
        Scroll() {
          Column() {
            ForEach(
              this.memoList,
              (_memo: MemoModel, index: number) => {
                // 笔记点击方法
                MemoItem({ memo: this.memoList[index] })
              },
              (memo: MemoModel) => {
                return memo.content
              }
            )
          }
        }

      }
      .width('100%')
      .height('100%')


      // 编辑弹窗
      if (this.isEditDialogShow) {
        CustomEditDialog({
          editContent: $editContent,
          onClose: this.closeDialog,
          onDelete: this.deleteMemo,
          onSave: this.saveMemo
        })
      }

    }
    .width('100%')
    .height('100%')
  }
}