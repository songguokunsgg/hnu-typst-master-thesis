#import "hnu-thesis/template.typ": documentclass, tablex, fig, tlt, indent, 字体, 字号
#import "hnu-thesis/template.typ": tablex, gridx, hlinex, vlinex, colspanx, rowspanx, tophlinex, midhlinex, bottomhlinex, midvlinex, topvlinex, bottomvlinex

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
    title: ("基于 Typst 的", "湖南师范大学硕士学位论文"),
    title-en: "My Title in English",
    grade: "2021",
    student-id: "202120293792",
    author: "张三",
    author-en: "Xing Ming",
    department: "信息科学与工程学院",
    department-en: "School of Chemistry and Chemical Engineering",
    major: "计算机科学与技术",
    major-en: "some major",
    supervisor: ("李四", "教授"),
    supervisor-en: "Professor My Supervisor",
    // supervisor-ii: ("王五", "副教授"),
    // supervisor-ii-en: "Professor My Supervisor",
    submit-date: datetime.today(),
  ),
)

// 文稿设置
#show: doc.with(margin: (x: 28mm, y:25mm))

// 封面页
#cover()

// 声明页
#decl-page()


// 前言
#show: preface

// 中文摘要
#abstract(
  keywords: ("Typst", "模板", "HNU", "master")
)[
  本研究旨在开发一个基于Typst的硕士论文模板，为湖南师范大学（HNU）的硕士研究生撰写论文提供便捷。Typst是一款新型的排版软件，具有简单易用、功能强大的特点。本研究首先分析了硕士论文的结构和排版要求，然后利用Typst的编程功能，设计并实现了一套完整的硕士论文模板。该模板涵盖了论文封面、摘要、目录、正文、参考文献等部分，可满足大部分硕士论文的排版需求。硕士研究生可以更加专注于论文内容的撰写，提高论文写作效率。本研究成果有望为湖南师范大学乃至其他高校的硕士研究生提供一种便捷、高效的论文排版解决方案。但要注意的是，该模板没有经过官方认证，建议在使用时基于Word、TeX Live或者MacTeX等软件做好方案B，以免造成不必要的麻烦。

]

// 英文摘要
#abstract-en(
  keywords: ("typst", "template", "HNU", "master")
)[
  This study aims to develop a master's thesis template based on Typst for master's students at Hunan Normal University (HNU), providing a convenient tool for writing theses. Typst is a new typesetting software known for its simplicity and powerful features. This research first analyzed the structure and typesetting requirements of master's theses and then utilized Typst's programming capabilities to design and implement a complete set of master's thesis templates. The template covers sections such as the cover page, abstract, table of contents, main text, references, and more, meeting the typesetting needs of most master's theses. Master's students can focus more on the content of their theses, improving their writing efficiency. The findings of this study are expected to provide an efficient and convenient typesetting solution for master's students at Hunan Normal University and potentially other institutions. However, it is important to note that this template is not officially certified; please have a backup plan using software such as Word, TeX Live, or MacTeX before use.
]

// 目录
#outline-page()

// 正文
#show: mainmatter

#import "@preview/ctheorems:1.1.1": *
#show: thmrules // 添加定理环境
#set heading(numbering: (..args) => {
  if args.pos().len() == 1 {
    return numbering("第1章", ..args.pos())
  } else {
    return numbering("1. 1", ..args.pos())
  }
})
#import "hnu-thesis/utils/theorem.typ": definition, theorem, corollary, example, proof, proposition

#import "@preview/lovelace:0.2.0": *
#show: setup-lovelace
#let algorithm = algorithm.with(supplement: "算法")

// 符号表
#notation[
  / DFT: 密度泛函理论 (Density functional theory)
  / DMRG: 密度矩阵重正化群密度矩阵重正化群密度矩阵重正化群 (Density-Matrix Reformation-Group)
]

= 快速入门

文件中只讲解常用的使用方式，不涉及复杂的语法和文档编排。如果需要技术指导，请查看README文档或者直接查看原南京大学模板项目README文档。

== 基本概念

- \[\] 包裹的是文本块
- \{\} 包裹的是代码块
- 代码块和文本块可以互相嵌套，如果没写括号，默认为文本。
- 如果某行中文没有缩进，使用\#indent加在前面
- 公式模式下，单个字符才是字符，多个字符是变量 $a = tan b$, 如果你写成a = tanb，会报错。而如果你想打a = tanb，你需要写成$a = t a n b$. \$前后空格很重要，如果你写为$ a=tan b $，这将是行间公式。
- 作用域。也就是set命令，set之后会影响整个文档。举例来说，`#text(weight: "bold")[bold text]`仅仅会加粗传入的参数，而`#set text(weight: "bold")`会影响「到作用域结束」，（或者，如果不在作用域中，影响文档的剩余部分）。根据使用方式的不同（函数调用/使用set命令），很容易区分它的作用域。
- 包导入。使用\#import命令。

好了，你已经入门了，可以继续学习了。建议在使用过程中学习，效率更高。

== 章节标题，黑体、斜体

LaTeX 使用 \\section 命令创建章节标题。多级标题分别用 \\subsection、\\subsection 等表示。根据文档种类的不同，还有 \\part 和 \\chapter。

在 Typst 中，标题设置更简洁：在标题所在的行前面加上一个等号和一个空格，便得到了一级标题：= Introduction。 如果你需要一个二级标题，则可以使用两个等号：== In this paper。 通过在前面加上更多的等号，你可以嵌套任意层级的标题。这一点上更接近 Markdown 中 `#` 的作用，在接下来的阅读中你会不断看到这种「Markdown + LaTeX」杂糅的产物，结合这两者分别的痛点，可以更加深入了解 Typst 设计这些语法的原因。

英文斜体使用 _itali_, 粗体使用 *black*。中文有所不同，目前还没有原生支持中文粗体，你可以通过 set 设置字体的方式来曲线救国，从而实现黑体和斜体。。

== 列表

使用方法如下：

- 无序列表 
- 无序列表2
- 无序列表3

+ 有序列表 
+ 有序列表2
+ 有序列表3

== 代码 (与markdown完全一致)

=== 行内代码
\`npm install react-dom\` 效果如下：

`npm install react-dom`

=== 行间代码

python示例：

\`\`\`python

import numpy as np

print(np.zeros((10,10)))

\`\`\`

效果如下：

```python
import numpy as np
print(np.zeros((10,10)))
```

c++示例：
```cpp
int main() {
  return 0;
}
```
代码会自动提供高亮。

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
    gridx(
      columns: 4,
      tophlinex(),
      [t], [1], [2], [3],
      midhlinex(),
      [y], [0.3s], [0.4s], [0.8s],
      bottomhlinex(),
    ),
    caption: [三线表],
  ) <timing-tlt>
]))

表格看似复杂，但使用gpt或者chatglm都可以轻松学会转化规则，直接让AI帮助转化即可。

如果你希望直接导入一个csv文件，或者，那么你有可能无法手动绘制三线。这时候你可以使用 tlt 函数。

#let tbs = csv("tables/test.csv")
#align(center, (stack(dir: ltr)[
  #fig(
    tlt(
    columns: 4,
    ..tbs.flatten()
  ),
  caption: [测试csv],
) <csv>
]))

#fig(
  image("hnu-thesis/assets/vi/hunnu_log_red.png", width: 50%),
  caption: [图片测试],
) <nju-logo>

注意，Typst目前不支持插入pdf和eps图片，需要转换为svg或者png等图片格式，可以使用inkscape、Adobe AI 软件或者相关网站转换。并且我在使用svg格式的图片时，出现了一些问题，因为本文档内，我暂时使用的是png格式。

== 公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

#indent 图表和公式后的段落要用 `#indent` 手动缩进。同时，我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 定理环境

使用 https://github.com/sahasatvik/typst-theorems 作为定理环境。常用的主要有definition、example、theorem、proof和corolary。

#definition[
  这是一条中文的定义，如果这条句子很长，定义是可以自动进行换行的。
]
#example[
  这是示例的使用情况，他们都可以使用英文书写。
]

#theorem("括注可以这样子写")[
  这是一条定理环境。
]
#proof[
  在这里写你的证明。你可以引用 @cor_largest_prime
]

#corollary[
  corolary 1.
] <cor_largest_prime>
#corollary[
  corolary 2. 
]

== 算法

- 表示无行号，+ 表示有行号

#algorithm(
  caption: [The Euclidean algorithm],
  pseudocode-list(
  line-number-transform: num => numbering("1:", num),
  indentation-guide-stroke: .5pt,
)[
  - *input:* integers $a$ and $b$
  - *output:* greatest common divisor of $a$ and $b$
  + *while* $a != b$ *do*
    + *if* $a > b$ *then*
      + $a <- a - b$
    + *else*
      + $b <- b - a$
    + *end*
  + *end*
  + *return* $a$
]
) <alg:test>

这是@alg:test

== 参考文献

建议使用betterbibtex导出bib文件，调整好citekey后直接\@citekey即可

机器学习是一门人工智能（AI）的分支@wehenkelUnconstrainedMonotonicNeural2019，主要研究如何让计算机从数据或经验中学习，并据此进行预测或决策@wangHuanJieSuiJiYiZhiXingDeJiNiZhiShuYuJueCeShuFangFa2023。简单来说，机器学习就是用算法来解析数据、从中学习、然后做出决策或预测。
机器学习可以分为几种主要类型：

1. *监督学习（Supervised Learning）*: 在这种模式下，算法从标记过的训练数据中学习，然后用学到的知识来预测新的、未标记的数据@granittoNeuralNetworkEnsembles2005。例如，通过分析过去的房价数据来预测未来的房价。
2. *无监督学习（Unsupervised Learning）*: 算法在没有标记的数据集上进行训练，试图自己找出数据内在的结构或规律。聚类和关联规则学习就是两个常见的例子@danielsMonotonePartiallyMonotone2010。
3. *半监督学习（Semi-supervised Learning）*: 这是一种介于监督学习和无监督学习之间的方法，其中一部分数据是标记的，但大部分数据是未标记的。
4. *强化学习（Reinforcement Learning）*: 在这种类型中，算法（通常被称为“智能体”）通过与环境进行交互来学习如何完成特定任务。智能体会获得奖励或惩罚@huangMobileNetworkTraffic2022，以便调整其行为。

机器学习在各个领域都有广泛的应用，包括但不限于自然语言处理、图像识别、推荐系统、金融预测@wangTimeSeriesForecastingFuzzyProbabilistic2022 等。

机器学习也在中国得到了广泛的研究和应用，与国家的战略发展和人民群众的生活密切相关。例如，在医疗健康、工业制造、城市管理等领域都有出色的应用案例@wanNBDTNeuralBackedDecision2021。

另外，我放置了一份 CSL 文件于 bibs 文件夹下，但目前该文件无法正常使用，只能暂时保留，等后续更新。

= 写作模式

Typst 区分两种模式：「标记模式」和「脚本模式」。默认是「标记模式」。此模式下，你可以直接编排文本、使用不同的语法结构，如*使用星号标记粗体文本* 。

== 标记模式中使用命令

```typst
#let patterns = ("有", "无")
#for pattern in patterns [
  #for j in range(3) [
    #if (pattern == "有") [
      + it's the ordered list of #(j+1) \
    ] else [
      - it's the non-ordered list of #(j+1) \
    ]
  ]
]
```
#let patterns = ("有", "无")
#for pattern in patterns [
  #for j in range(3) [
    #if (pattern == "有") [
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

前面已经有了演示，再说明一下，在标记模式中，可以通过\#加命令来执行脚本，但这种做法美观性不佳，因此可考虑如下方式的代码块。
```typst
#{
  let vec = (1,2,3,4)
  for i in vec [
    #i \ //  # is used to get value
  ]
}
```
输出如下：\
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

```typst
#{
  let a = [from]
  let b = [*world*]
  [hello ]
  a + [ the ] + b
}
```

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

不要背这些优先级，需要优先的不要吝啬你的括号。

// 手动分页
#if (twoside) {
  pagebreak() + " "
}
// 参考文献
#bibliography(("bibs/中文参考文献.bib", "bibs/英文参考文献.bib"),
  style: "gb-7714-2015-numeric"
  // style: "bibs/hunnu.csl"
)

// 致谢
#acknowledgement[
  衷心感谢南京大学无私地分享的开源项目，为我们提供了一个优秀的硕士论文模板。在此，我向他表示由衷的感谢。
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
  image("hnu-thesis/assets/vi/hunnu_log_red.png", width: 20%),
  caption: [图片测试],
) <appendix-img>
