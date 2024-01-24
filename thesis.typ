#import "hnu-thesis/template.typ": documentclass, tablex, fig, tlt, indent

// 双面模式，会加入空白页，便于打印
#let twoside = false

#let (
  doc, preface, mainmatter, mainmatter-end, appendix,
  fonts-display-page, cover, decl-page, abstract, abstract-en, outline-page, notation, acknowledgement,
) = documentclass(
  type: "master",
  degree: "academic",
  anonymous: false,  // 盲审模式
  twoside: twoside,  // 双面模式，会加入空白页，便于打印
  // 可自定义字体，先英文字体后中文字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  // fonts: (楷体: ("Times New Roman", "FZKai-Z03S")),
  info: (
    title: ("基于 Typst 的", "湖南师范大学学位论文"),
    title-en: "My Title in English",
    grade: "2021",
    student-id: "202120293792",
    author: "姓名",
    author-en: "Xing Ming",
    department: "信息科学与工程学院",
    department-en: "School of Chemistry and Chemical Engineering",
    major: "某专业",
    major-en: "some major",
    supervisor: ("张三的", "教授"),
    supervisor-en: "Professor My Supervisor",
    // supervisor-ii: ("王五", "副教授"),
    // supervisor-ii-en: "Professor My Supervisor",
    submit-date: datetime.today(),
  ),
)

// 文稿设置
#show: doc

// 封面页
#cover()

// 声明页
#decl-page()


// 前言
#show: preface

// 中文摘要
#abstract(
  keywords: ("我", "就是", "测试用", "关键词")
)[
  中文摘要
]

// 英文摘要
#abstract-en(
  keywords: ("Dummy", "Keywords", "Here", "It Is")
)[
  English abstract
]

// 目录
#outline-page()

// 正文
#show: mainmatter

// 符号表
#notation[
  / DFT: 密度泛函理论 (Density functional theory)
  / DMRG: 密度矩阵重正化群密度矩阵重正化群密度矩阵重正化群 (Density-Matrix Reformation-Group)
]

= 快速入门

这里只讲解常用的*使用*方式，不涉及复杂的语法和文档编排。

== 章节标题，黑体、斜体

LaTeX 使用 \\section 命令创建章节标题。多级标题分别用 \\subsection、\\subsection 等表示。根据文档种类的不同，还有 \\part 和 \\chapter。

在 Typst 中，标题设置更简洁：在标题所在的行前面加上一个等号和一个空格，便得到了一级标题：= Introduction。 如果你需要一个二级标题，则可以使用两个等号：== In this paper。 通过在前面加上更多的等号，你可以嵌套任意层级的标题。这一点上更接近 Markdown 中 `#` 的作用，在接下来的阅读中你会不断看到这种「Markdown + LaTeX」杂糅的产物，结合这两者分别的痛点，可以更加深入了解 Typst 设计这些语法的原因。

英文斜体使用 _itali_, 粗体使用 *black*。中文有所不同，目前还没有原生支持中文粗体。

== 列表

- 无序列表 
- 无序列表2
- 无序列表3

+ 有序列表 
+ 有序列表2
+ 有序列表3

== 代码

=== 行内代码
`npm install react-dom`

=== 行间代码
```python
import numpy as np
print(np.zeros((10,10)))
```

== 脚注

我们可以添加一个脚注。#footnote[脚注内容]

== 链接

这是一个链接 https://typst.app

== 引用标签

对应latex中的\\label{XX}
在定义后使用\<citekey\>即可，关于这点，在下面的图表和公式有详细说明。

== 图表

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:nju-logo。引用图表时，表格、图片和代码分别需要加上 `tbl:`、`fig:` 和 `lst:` 前缀才能正常显示编号。以及这里使用 `fig` 函数替代原生 `figure` 函数以支持将 `tablex` 作为表格来识别。

#align(center, (stack(dir: ltr)[
  #fig(
    tablex(
      align: center + horizon,
      columns: 4,
      [t], [1], [2], [3],
      [y], [0.3s], [0.4s], [0.8s],
    ),
    caption: [常规表],
  ) <timing>
][
  #h(50pt)
][
  #fig(
    tlt(
      columns: 4,
      [t], [1], [2], [3],
      [y], [0.3s], [0.4s], [0.8s],
    ),
    caption: [三线表],
  ) <timing-tlt>
]))

表格看似复杂，但使用gpt或者chatglm都可以轻松学会转化规则，直接让AI帮助转化即可。

#fig(
  image("hnu-thesis\assets\vi\hunnu_log_black.svg", width: 20%),
  caption: [图片测试],
) <nju-logo>


== 公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

#indent 图表和公式后的段落要用 `#indent` 手动缩进。同时，我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献

可以像这样引用参考文献：@wang2010guide 和 @kopka2004guide。

建议使用betterbibtex导出bib文件，调整好citekey后直接\@citekey即可

= 标记模式

Typst 区分两种模式：「标记模式」和「脚本模式」。 默认是「标记模式」。此模式下，你可以直接编排文本、使用不同的语法结构，如 *使用星号标记粗体文本* 。

== 标记模式中使用命令

```typst
#let pattern = ("有", "无")
#for i in pattern [
  #for j in range(3) [
    #if (pattern.at(0) == "有") [
      + it's the ordered list of #(j+1) \
    ] else [
      - it's the non-ordered list of #(j+1) \
    ]
  ]
]
```
#let pattern = ("有", "无")
#for i in pattern [
  #for j in range(3) [
    #if (pattern.at(0) == "有") [
      + it's the ordered list of #(j+1) \
    ] else [
      - it's the non-ordered list of #(j+1) \
    ]
  ]
]

可以极大地减少重复文本以及多处引用相同文本情况的错误率。
此功能上限很高，发挥你的想象力。

= 脚本/代码模式
「代码模式」下，则更类似像 Python 一样的编程语言，提供了输入、执行代码的选项。

== 数组 array

=== 基本用法

前面已经有了演示，再说明一下，在标记模式中，可以通过\#加命令来执行脚本，但这种做法美观性不佳，因此可考虑如下方式。
```typst
  let vec = (1,2,3,4)
  for i in vec [
    #i \ // #: get var's value
  ]
```
输出如下：
#{
  let vec = (1,2,3,4)
  for i in vec [
    #i \ // 这里的 # 表示取值
  ]
}

=== 解构赋值


```typst
let (x, y) = (1, 2)
[The coordinates are #x, #y.]

let (a, .., b) = (1, 2, 3, 4)
[The first element is #a.]
[The last element is #b.]

let (_, y, _) = (1, 2, 3)
[The y coordinate is #y.]
```
#{
  let (x, y) = (1, 2)
  [The coordinates are #x, #y.]

  let (a, .., b) = (1, 2, 3, 4)
  [The first element is #a.]
  [The last element is #b.]

  let (_, y, _) = (1, 2, 3)
  [The y coordinate is #y.]
}

自己感受一下，跟一般的编程语言差不多

文档内容块和代码块可以相互内嵌，下面示例中，[hello] 与 a + [ the ] + b 合并，生成 [hello from the *world*]。

#{
  let a = [from]
  let b = [*world*]
  [hello ]
  a + [ the ] + b
}

注意，\[\]中的空格不会被忽略。

除此之外，数组还可以添加元素删除元素等，但这方面功能过于脚本化，对普通用户作用不大，故不赘述。

== 字典

字典结构就是键值对结构，能够存储一些固定信息。
```typst
#{
  let expResult = (
    Accuracy: 98.8%,
    MAE: 1.2%,
    recall: 0.34,
  )
  // Destructuring
  let (Accuracy, MAE, recall:RC) = expResult
  [The experiment of accuracy is #Accuracy, MAE is #MAE, and Recall is  #RC]
  
  [The accuracy is #expResult.Accuracy, MAE is #expResult.MAE, and Recall is #expResult.recall]
}
```

也可以只获取某些内容

```typst
#{
  let expResult = (
    Accuracy: 98.8%,
    MAE: 1.2%,
    recall: 0.34,
  )
  let (Accuracy, ) = expResult
  let (Accuracy, ..other) = expResult
}
```

这种变量极大方便了前后跨度大且提到同一个数据的时候，可以大幅度避免改漏某个数据的情况。

= 流程控制语句

== for 循环 & while 循环

```typst
#{
  // Array is wroten above
  for ch in "Apple" [
    #ch is a letter in _Apple_.
  ]

  let expResult = (
    Accuracy: 98.8%,
    MAE: 1.2%,
    recall: 0.34,
  )

  for (key, value) in expResult {
    [The #key of experiment is #value，]
  }
}
```

以下是while 循环，while循环似乎不能在脚本模式使用

```typst
#let n = 2
#while n < 10 {
  n = (n * 2) - 1
  (n,)
}
```

== if 语句

每个分支从句可以写为语句块或者文档内容块。

- if condition {..}
- if condition [..]
- if condition [..] else {..}
- if condition [..] else if condition {..} else [..]

```typst
#{
  let criteria = 0.95
  let expResult = (
    Accuracy: 98.8%,
    MAE: 1.2%,
    recall: 0.34,
  )

  // ratio can't be compared with float, converting it is neccesary.
  if (float(expResult.Accuracy) > criteria) [
    Accuracy #expResult.Accuracy is better.
  ] else {
    [The accuracy is worse.]
  }
}
```

= 冷门操作符

#fig(
  tlt(
    columns: 4,
    [操作符], [作用说明], [参数数量], [优先级],
    [in], [属于], [二元], [4],
    [not in], [不属于], [二元], [4],
    [not], [逻辑非], [一元], [3],
    [and], [短路式逻辑并], [二元], [3],
    [or], [短路式逻辑或], [二元], [2],
    [+=], [相加赋值], [二元], [1],
    [-=], [相减赋值], [二元], [1],
    [\*=], [相乘赋值], [二元], [1],
    [/=], [相除赋值], [二元], [1],
  ),
  caption: [操作符表格],
) <operator-table>


// 手动分页
#if (twoside) {
  pagebreak() + " "
}
// 参考文献
#bibliography(("bibs/ex01.bib", "bibs/ex02.bib"),
  style: "ieee"
)

// 致谢
#acknowledgement[
  感谢 NJU-LUG，感谢 NJUThesis LaTeX 模板。
]

// 手动分页
#if (twoside) {
  pagebreak() + " "
}

// 正文结束标志，不可缺少
#mainmatter-end()

// 附录
#show: appendix

= 附录

== 附录子标题

=== 附录子子标题

附录内容，这里也可以加入图片，例如@fig:appendix-img。

#fig(
  image("hnu-thesis\assets\vi\hunnu_log_black.svg", width: 20%),
  caption: [图片测试],
) <appendix-img>
