#import "@preview/cetz:0.1.2"
#import "@preview/algorithmic:0.1.0"
#import "../slide.typ"
#show: slide.style
#show link: slide.link
#show footnote.entry: slide.footnote

#let algorithm(..args) = text(font: ("linux libertine", "Pretendard"), size: 17pt)[#algorithmic.algorithm(..args)]
#let func(body) = text(font: ("linux libertine", "Pretendard"))[#smallcaps[#body]]

#align(horizon + center)[
  = 알고리즘 기초 세미나
  03: 선형 자료구조

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.12.06.r1
  ]
]

#slide.slide[선형 자료구조][
  - 자료(data)의 선형 위치 관계를 준 것

  - 한 자료의 위치로 다른 자료의 위치를 알 수 있음

  - 선형 #sym.dash.em 자료끼리 일직선, 등간격

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      grid((0, 0), (1.5, 6), step: 1.5, name: "vert")
      grid((rel: (1, -.75), to: "vert.right"), (rel: (7, .75), to: "vert.right"), step: 1.5)
    })
  ]
]

#slide.slide[정렬][
  - 자료에 순서를 부여하는 방법

  - 자료의 위치와 자료의 순서가 연관됨 (단조성)

  - 중복과 관련된 처리가 용이

  - 일반적으로 표준 라이브러리에는 배열에 대한 $cal(O)(N log N)$ 구현 존재
]

#slide.slide[과제][
  - #slide.problem("27522", "카트라이더: 드리프트")

  - #slide.problem("29723", "브실이의 입시전략")

  - #slide.problem("30684", "모르고리즘 회장 정하기")
]


#slide.slide[동적 배열][
  - 컴퓨터는 값을 메모리 공간에 저장

  - 메모리 공간은 일반적으로 커다란 배열

  - 메모리 주소 = 배열의 인덱스
    - 인덱스 접근은 $cal(O)(1)$

  - 자료를 하나 저장하는 데 필요한 인덱스의 개수를 알면 $cal(O)(1)$ 시간에 $i$번째 자료의 메모리 주소를 알 수 있음

  $ "addr"(i) = i times "count" + "base" $

  #pagebreak()

  - 값을 저장하기 위해서는 메모리 공간의 사용을 미리 허락받아야 함 = 할당

  - "동적" #sym.dash.em 허락받을 공간의 크기가 자꾸 변해요

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let memory = (top-left, count, ..opt) => {
        group({
          set-origin(top-left)
          grid((0, 0), (1.5 * 15, 1.5), step: 1.5)
          content((1.5 * (2 + count / 2), 0.75), [배열], frame: "rect", stroke: none, fill: white, padding: 0.25)
          rect((1.5 * 2, 0), (1.5 * (2 + count), 1.5), fill: rgb(100%, 0, 0, 20%))
          content((1.5 * (7 + 6 / 2), 0.75), [사용 중인 영역], frame: "rect", stroke: none, fill: white, padding: 0.25)
          rect((1.5 * 7, 0,), (1.5 * (7 + 6), 1.5), fill: rgb(0, 0, 100%, 20%))
        }, ..opt)
      }
      memory((0, 6), 4, name: "size-4")
      set-style(
        mark: (
          end: ">",
          size: 0.3,
          fill: black,
        )
      )
      group({
        set-origin("size-4.bottom")
        line((0, -0.25), (0, -1.25))
        content((0.5, -0.75), [원소 추가], anchor: "left")
      })
      memory((0, 3), 5, name: "size-5")
      group({
        set-origin("size-5.bottom")
        line((0, -0.25), (0, -1.25))
        content((0.5, -0.75), [원소 추가?], anchor: "left")
      })
      memory((0, 0), 6)
    })
  ]

  #pagebreak()

  - 매번 새로운 공간을 할당하고 *기존 원소를 복사* #sym.dash.em $cal(O)(N)$?

  - 할당하는 크기를 항상 $2^K$으로!

  - 크기가 $2^K$에 도달하기 위해서는 복사가 $2^0 + 2^1 + 2^2 + dots.c + 2^(K-1)$번

  $ sum_(i=0)^(K-1) 2^i = (2^K - 1) / (2 - 1) = 2^K - 1 $

  - 크기가 $N$일 때 복사가 $cal(O)(N)$번
  
  - 크기가 $1$ 늘어날 때 전체 복사 수가 $cal(O)(1)$ 증가한다고 생각하기
]

#slide.slide[스택][
  - 자료구조의 한 끝을 정해, 그곳에서만 추가와 삭제가 일어나는 자료구조

  - 많은 언어의 동적 배열은 스택의 기능을 가짐
    - 자료구조의 끝에 추가 $cal(O)(1)$
    - 자료구조의 끝에서 삭제 $cal(O)(1)$

  - 가장 최근에 본 자료에 초점을 맞출 때 사용

  #pagebreak()

  - *짝 맞추기 유형*

  - 여러 종류의 괄호가 포함된 문자열에서 각 괄호의 짝이 맞는지 판단하기

  #align(center)[
    `(The quick {brown fox} jumps over [the lazy (dog)])` \
    #text(fill: red)[`(`]`The quick {brown`#text(fill: red)[`)`]` fox} jumps over {[the lazy dog]}`
  ]

  - 괄호마다 들어 있는 원소의 개수를 출력하기

  - 문제를 괄호 문제로 환원하는 것이 중요

  #pagebreak()

  - *스택을 정렬된 상태로 유지하기*

  - 어렵기 때문에 생략

  - 생각해보면 좋아요
]

#slide.slide[과제][
  - #slide.problem("30047", "함수 문자열")
  
  - #slide.problem("17952", "과제는 끝나지 않아!")

  - #slide.problem("11899", "괄호 끼워넣기")
]

#slide.slide[덱][
  - 자료구조의 양쪽 끝에서 추가와 삭제가 가능한 자료구조 ($cal(O)(1)$)

  - 정렬된 상태로 유지하기 외에는, 양쪽에서 추가 및 삭제하는 요구사항이 비교적 명시적
]

#slide.slide[과제][
  - #slide.problem("28066", "타노스는 요세푸스가 밉다")

  - #slide.problem("28107", "회전초밥")
]

#slide.slide[누적 합][
  - 수열 $a_1, a_2, dots.c, a_N$이 주어질 때, 구간 합 $a_l + a_(l+1) + dots.c + a_r$을 구하기

  - $cal(O)(N)$보다 빠르게 할 수 있을까?

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz.decorations: brace
      grid((0, 0), (1.5 * 15, 1.5), step: 1.5)
      rect((1.5 * 2, 0), (1.5 * (2 + 6), 1.5), fill: rgb(100%, 0, 0, 20%))
      rect((1.5 * 5, 0), (1.5 * (5 + 10), 1.5), fill: rgb(0, 0, 100%, 20%))
      rect((1.5 * 7, 0), (1.5 * (7 + 6), 1.5), fill: rgb(100%, 100%, 0, 20%))
      brace((1.5 * 2, -.2), (1.5 * (2 + 6), -.2), flip: true)
      brace((1.5 * 5, 1.7), (1.5 * (5 + 10), 1.7), amplitude: 1.5, pointiness: 45deg)
      brace((1.5 * 7, 1.7), (1.5 * (7 + 6), 1.7))
      for i in range(15) {
        content((1.5 * (i + 0.5), 0.9), $a_#{i+1}$, anchor: "center")
      }
    })
  ]
  
  - 아이디어: 겹치는 부분을 줄이려면 여러 개를 모아서 저장하면 좋지 않을까?

  #pagebreak()

  - $S_i = a_1 + a_2 + dots.c + a_i$를 저장하자!

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz.decorations: brace
      grid((0, 0), (1.5 * 15, 1.5), step: 1.5)
      rect((1.5 * 2, 0), (1.5 * (2 + 6), 1.5), fill: rgb(100%, 0, 0, 20%))
      rect((1.5 * 5, 0), (1.5 * (5 + 10), 1.5), fill: rgb(0, 0, 100%, 20%))
      rect((1.5 * 7, 0), (1.5 * (7 + 6), 1.5), fill: rgb(100%, 100%, 0, 20%))

      brace((1.5 * 2, -.2), (1.5 * (2 + 6), -.2), flip: true)
      let mid1 = (1.5 * 2 + 7, -1.2)
      grid((rel: (-1 * 8, -1), to: mid1), (rel: (0, 0), to: mid1), step: 1)
      content((rel: (0.5, -0.4), to: mid1), $-$, anchor: "center")
      grid((rel: (-1 * 2 + 3, -1), to: mid1), (rel: (3, 0), to: mid1), step: 1)

      brace((1.5 * 5, 1.7), (1.5 * (5 + 10), 1.7), amplitude: 3, pointiness: 45deg)
      let mid2 = (1.5 * 5 + 8, 4)
      grid((rel: (-1 * 15, 1), to: mid2), (rel: (0, 2), to: mid2), step: 1)
      content((rel: (0.5, 1.6), to: mid2), $-$, anchor: "center")
      grid((rel: (-1 * 5 + 6, 1), to: mid2), (rel: (6, 2), to: mid2), step: 1)

      brace((1.5 * 7, 1.7), (1.5 * (7 + 6), 1.7))
      let mid3 = (1.5 * 7 + 3, 1.75)
      rect((rel: (-1 * 13, 1), to: mid3), (rel: (8, 2), to: mid3), stroke: none, fill: white)
      grid((rel: (-1 * 13, 1), to: mid3), (rel: (0, 2), to: mid3), step: 1)
      content((rel: (0.5, 1.6), to: mid3), $-$, anchor: "center")
      grid((rel: (-1 * 7 + 8, 1), to: mid3), (rel: (8, 2), to: mid3), step: 1)

      for i in range(15) {
        content((1.5 * (i + 0.5), 0.9), $a_#{i+1}$, anchor: "center")
      }
    })
  ]

  #pagebreak()

  $
    S_r &= a_1 + a_2 + dots.c + a_(l - 1) &+ a_l + dots.c + a_r \
    S_(l - 1) &= a_1 + a_2 + dots.c + a_(l - 1) \
    S_r - S_(l - 1) &= &a_l + dots.c + a_r
  $

  - $S_i$를 $cal(O)(N)$에 미리 계산해 두면 구간 합이 $cal(O)(1)$

  - 하지만 $a_i$가 중간에 바뀐다면? #sym.dash.em 고급에서 만나요
]

#slide.slide[과제][
  - #slide.problem("23827", "수열 (Easy)")

  - #slide.problem("21921", "블로그")

  - #slide.problem("25947", "선물할인")

  - #slide.problem("28427", "Tricknology")
]