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
  04: 탐색

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2024.05.23.r1
  ]
]

#slide.slide[탐색][
  - 자료구조에서 자료의 위치를 찾는 것

  - 자료구조 내 모든 원소를 보는 전략: $cal(O)(N)$

  - 특히 선형 자료구조의 경우는 *선형 탐색*
]

#slide.slide[이분 탐색][
  - *정렬된* 선형 자료구조에서 빠르게 탐색

  - 찾으려는 원소 $x$와 모든 원소 $a_i$에 대해서 셋 중 하나가 성립
    - $x < a_i$
    - $x = a_i$
    - $x > a_i$
  
  - $x != a_i$라면 찾으려는 자료 $a_j$는 $j < i$와 $j > i$ 둘 중 하나

  - 찾는 구간을 반씩 줄일 수 있음

  - $2^f(N) >= N$에서, $f(N) = cal(O)(log_2 N) = cal(O)(log N)$

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function([Binary-Search], args: ($A$, $x$), {
      Assign[$l$][0]
      Assign[$r$][#FnI[len][$A$]]
      While(
        cond: $l < r$, {
          Assign[$m$][#FnI[midpoint][$l$, $r$]]
          If(
            cond: $A[m] < x$,
            Assign[$l$][$m + 1$]
          )
          ElseIf(
            cond: $A[m] = x$,
            Return[$m$]
          )
          Else(
            Assign[$r$][$m$]
          )
        }
      )
    })
  })

  - `while` 안에서 변하지 않는 속성(불변량) 찾기

  #pagebreak()

  - 빈출 유형
    - 배열의 정렬 상태를 유지하면서 주어진 값 $x$가 삽입될 수 있는 위치 찾기
    - $x$ 이상/이하/초과/미만의 최소/최대 원소 찾기
    - 헷갈리지 않으려면 이후에 나올 일반화 부분 참고

  - $x$가 배열 $A$에 존재할 것이라는 보장이 없음

  #pagebreak()
  #h(0pt)

  #algorithm({
    import algorithmic: *
    Function([Binary-Search], args: ($A$, $x$), {
      Assign[$l$][0]
      Assign[$r$][#FnI[len][$A$]]
      While(
        cond: $l < r$, {
          Assign[$m$][#FnI[midpoint][$l$, $r$]]
          If(
            cond: $A[m] < x$,
            Assign[$l$][$m + 1$]
          )
          Else(
            Assign[$r$][$m$]
          )
        }
      )
      Cmt[$l = r$]
      Return[$l$]
    })
  })

  - 무한루프를 피할 수 있을까?
]

#slide.slide[이분 탐색의 일반화][
  - 값을 찾는 구간이 `true`와 `false`로만 이루어진 대형 배열이라고 생각하기

  - `true` `true` ... `true` `false` `false` ... `false` 에서 첫 `false`의 위치를 찾음

  #align(center + horizon)[
    #cetz.canvas({
      import cetz.draw: *
      
      rect((0, 0), (1.5 * 4, 1.5), stroke: none, fill: rgb(0%, 100%, 0%, 20%))
      rect((1.5 * 4, 0), (1.5 * 10, 1.5), stroke: none, fill: rgb(100%, 0%, 0%, 20%))
      grid((0, 0), (1.5 * 10, 1.5), step: 1.5)

      line((1.5 * 4.5, -1.5), (1.5 * 4.5, -0.5), mark: (end: ">"))
    })
  ]

  #pagebreak()
  #h(0pt)

  #algorithm({
    import algorithmic: *
    Function([Partition-Point], args: ($f$, $min$, $max$), {
      Assign[$l$][$min$]
      Assign[$r$][$max$]
      While(
        cond: $l < r$, {
          Assign[$m$][#FnI[midpoint][$l$, $r$]]
          If(
            cond: $f(m)$,
            Assign[$l$][$m + 1$]
          )
          Else(
            Assign[$r$][$m$]
          )
        }
      )
      Cmt[$l = r$]
      Return[$l$]
    })
  })
]

#slide.slide[과제][
  - #slide.problem("26258", "다중 일차 함수")

  - #slide.problem("27968", "사사의 사차원 사탕 봉지")

  - #slide.problem("28103", "대회 상품 정하기")
]

#slide.slide[매개 변수 탐색][
  - 조건을 만족하는 최솟값을 구하는 문제

  - 최솟값으로 접근해가는 방법이 명확하게 떠오르지 않을 때

  - 답이 단조성\*을 띨 때 사용 가능

  - 답을 변수 $x$로 두고 조건을 만족하는지 / 만족하지 않는지로 이분 탐색

  - 조건 판정에 $cal(O)(f(N))$ 시간이 걸릴 때 $cal(O)(f(N) log X)$ 시간
]

#slide.slide[과제][
  - #slide.problem("15810", "풍선 공장")

  - #slide.problem("2805", "나무 자르기")

  - #slide.problem("27977", "킥보드로 등교하기")
]
