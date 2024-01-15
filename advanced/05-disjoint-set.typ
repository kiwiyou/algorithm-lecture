#import "@preview/cetz:0.1.2"
#import "@preview/algorithmic:0.1.0"
#import "../slide.typ"
#show: slide.style
#show link: slide.link
#show footnote.entry: slide.footnote

#let algorithm(..args) = text(
  font: ("linux libertine", "Pretendard"),
  size: 17pt,
)[#algorithmic.algorithm(..args)]
#let func(body) = text(font: ("linux libertine", "Pretendard"))[#smallcaps[#body]]

#align(horizon + center)[
  = 알고리즘 중급 세미나
  05: 분리 집합

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.01.15.r1
  ]
]

#slide.slide[분리 집합][
  - 정점 $V$개가 있을 때, 다음 쿼리 $Q$개를 처리하기
    - `1 u v`: $u$와 $v$를 잇는 양방향 간선을 추가
    - `2 u v`: $u$와 $v$ 사이를 이동할 수 있는지 출력

  - DFS를 이용하면 1번 쿼리에 $cal(O)(1)$, 2번 쿼리에 $cal(O)(V)$

  - 더 빠르게 할 수 있을까?
]

#slide.slide[분리 집합][
  - 집합 $N$개에 각각 대표 원소 $1, 2, dots, N$이 있을 때, 다음 연산을 처리
    - 원소 $a$가 포함된 집합의 대표 원소 찾기: `find(a)`
    - 집합 $A$와 $B$를 모두 두 집합의 합집합으로 대체: `union(a, b)`

  - A가 B를 포함하면 B의 부모를 A로 설정, 전체 집합을 트리 구조로 표현

  - `find(a)`는 트리의 루트를 찾는 연산

  - `union(a, b)`는 루트와 루트 사이에 간선을 추가하는 연산

  #pagebreak()

  - `find`의 최적화

  - 편의상 집합 번호 = 대표 원소로 두고, 부모가 자신과 같으면 루트로 정의 

  #algorithm({
    import algorithmic: *
    Function([Find], args: ($a$, ), {
      Assign[$r$][$a$]
      While(cond: $"parent"(r) eq.not r$, {
        Assign[$r$][$"parent"(r)$]
      })
      Return[$r$]
    })
  })

  - 매번 루트까지 올라가야 하므로 최악 $cal(O)(N)$

  #pagebreak()

  - 루트까지 올라간 결과를 저장해 두기

  #algorithm({
    import algorithmic: *
    Function([Find], args: ($a$, ), {
      Assign[$r$][$a$]
      While(cond: $"parent"(r) eq.not r$, {
        Assign[$r$][$"parent"(r)$]
      })
      Assign[$"parent"(a)$][$r$]
      Return[$r$]
    })
  })

  - 여전히 amortized $cal(O)(N)$

  - 재귀를 이용하여 매 반복마다 저장해 둔다면?

  #pagebreak()

  - 경로 압축#super[Path Compression]: amortized $cal(O)(log N)$ - 증명 생략
  #algorithm({
    import algorithmic: *
    Function([Find], args: ($a$, ), {
      If(cond: $"parent"(a) eq.not a$, {
        Assign[$"parent"(a)$][$"find"("parent"(a))$]
      })
      Return[$"parent"(a)$]
    })
  })

  #algorithm({
    import algorithmic: *
    Function([Find], args: ($a$, ), {
      Assign[$r$][$a$]
      While(cond: $"parent"(r) eq.not r$, {
        Assign[$"parent"(r)$][$"parent"("parent"(r))$]
        Assign[$r$][$"parent"(r)$]
      })
      Return[$r$]
    })
  })

  #pagebreak()

  - `union`의 최적화

  - Union by size

  #algorithm({
    import algorithmic: *
    Function([Union], args: ($a$, $b$ ), {
      If(cond: $"size"(a) < "size"(b)$, {
        Call([Union], [$b$, $a$])
      })
      Assign[$"size"(a)$][$"size"(a) + "size"(b)$]
      Assign[$"parent"(b)$][$a$]
    })
  })

  - 경로 압축 없이 amortized $cal(O)(log N)$, 경로 압축과 함께 amortized $cal(O)(alpha(N))$

  #pagebreak()

  - Union by rank

  #algorithm({
    import algorithmic: *
    Function([Union], args: ($a$, $b$ ), {
      If(cond: $"rank"(a) < "rank"(b)$, {
        Call([Union], [$b$, $a$])
      })
      If(cond: $"rank"(a) = "rank"(b)$, {
        Assign[$"rank"(a)$][$"rank"(a) + 1$]
      })
      Assign[$"parent"(b)$][$a$]
    })
  })

  - 경로 압축 없이 amortized $cal(O)(log N)$, 경로 압축과 함께 amortized $cal(O)(alpha(N))$

  - rank의 값은 최대 $log N$

  #pagebreak()

  - 실시간으로 사이클 판정 가능

  - 연결 요소 개수를 실시간으로 추적 가능

  - 다음 빈 공간 찾기
]

#slide.slide[과제][
  - #slide.problem("11085", "군사 이동")

  - #slide.problem("14595", "동방 프로젝트 (Large)")

  - #slide.problem("29618", "미술 시간")
]

#slide.slide[최소 스패닝 트리][
  - 스패닝 트리: 양방향 연결 그래프의 모든 정점을 포함하는 트리

  - 최소 스패닝 트리: 스패닝 트리 중 트리 간선의 가중치 합이 최소인 것

  - Prim, Kruskal 외 여러 가지 알고리즘이 있음
]

#slide.slide[Prim 알고리즘][
  - 한 정점에서 시작해서 가중치가 가장 작은 간선을 계속 붙여 나감

  - 붙일 수 있는 간선의 목록을 우선순위 큐로 관리하면 $cal(O)(E log V)$

]

#slide.slide[Kruskal 알고리즘][
  - 가중치가 작은 간선부터 차례대로, 사이클을 이루지 않는다면 트리에 추가

  - 정렬에 $cal(O)(E log E)$, 사이클 확인에 $cal(O)(E alpha(V))$
]

#slide.slide[과제][
  - #slide.problem("27945", "슬슬 가지를 먹지 않으면 죽는다")

  - #slide.problem("28473", "도로 위의 표지판")
]