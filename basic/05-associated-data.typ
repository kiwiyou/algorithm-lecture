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
  05: 연관 자료구조

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.01.11.r1
  ]
]

#slide.slide[맵][
  - 두 자료가 연관되어 있음

  - 한 자료로 다른 쪽 자료를 찾을 수 있음

  - 찾는 열쇠가 되는 자료가 키, 찾으려는 자료는 값
]

#slide.slide[해시를 이용한 맵][
  - 해시 함수: 모든 값을 고정된 길이의 값으로 변환하는 함수

  - 키에 해시 함수를 적용한 값을 사용하여 값을 찾음

  - 가장 간단한 구현으로, 배열을 만든 후 해시 값을 길이로 나눈 나머지 위치에 값을 저장

  - 삽입, 검색, 삭제에 모두 평균 $cal(O)(1)$, 최악 $cal(O)(N)$

  - 해시 충돌: 해시 값이 같은 키가 여럿 존재하는 경우
]

#slide.slide[트리를 이용한 맵][
  - 해시 함수를 이용하지 않고, 균형 잡힌 이진 검색 트리#super([BBST])를 이용하여 연관을 구현

  - 삽입, 검색 및 삭제에 모두 $cal(O)(log N)$

  - 키에 관한 이분 탐색이 가능
]

#slide.slide[집합 자료구조][
  - 키와 연관된 값 없이 자료의 존재 여부만 확인할 수 있는 자료구조
]

#slide.slide[과제][
  - #slide.problem("26069", "붙임성 좋은 총총이")

  - #slide.problem("29721", "변형 체스 놀이 : 다바바(Dabbaba)")

  - #slide.problem("29714", "브실이의 구슬 아이스크림")
]

#slide.slide[우선순위 큐][
  - 자료마다 우선순위가 부여됨

  - 삽입된 값 중 우선순위가 높은 값이 먼저 삭제됨\*

  - 보통 이진 힙으로 구현: 삽입, 삭제에 $cal(O)(log N)$
]

#slide.slide[우선순위 큐][
  - #slide.problem("14235", "크리스마스 선물")

  - #slide.problem("23757", "아이들과 선물 상자")

  - #slide.problem("28107", "회전초밥")
]
