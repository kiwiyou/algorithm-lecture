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
  07: 그래프

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.02.01.r1
  ]
]

#slide.slide[그래프][
  - $V$개의 정점과 $E$개의 간선의 집합

  - 한 간선은 두 정점을 연결

  - 정점에는 번호가 있을 수 있고, 간선에는 방향과 가중치가 있을 수 있음

  #pagebreak()

  - 간선의 존재 여부

  - 정점에 연결된 간선 탐색

  #pagebreak()

  - 인접 행렬

  - $V times V$ 행렬 $[a_(i j)]$에서, $i -> j$ 간선이 있으면 $a_(i j) = 1$, 아니면 $0$

  - $V times V$ 행렬 $[a_(i j)]$에서, $i -> j$ 간선의 가중치가 $w$라면 $a_(i j) = w$

  - 간선의 존재 여부 $cal(O)(1)$ 시간

  - 정점에 연결된 간선 탐색 $cal(O)(V)$ 시간

  - 두 정점 사이에는 최대 한 개의 간선

  - 공간복잡도 $cal(O)(V^2)$

  #pagebreak()

  - 인접 리스트

  - $V$개의 리스트 $L[u]$를 관리

  - $L[u]$는 $u -> v$ 간선이 존재하는 모든 $v$ (와 간선 가중치 $w$)의 리스트

  - 간선의 존재 여부 $cal(O)(E)$ 시간

  - 정점에 연결된 간선 탐색 $cal(O)(E)$ 시간

  - 공간복잡도 $cal(O)(V + E)$

  #pagebreak()

  - 그래프 탐색: 연결된 정점들을 한 번씩 방문

  - 깊이 우선 탐색: 연결되어 있고 아직 방문하지 않은 정점을 하나 골라 탐색

  - 너비 우선 탐색: 아직 방문하지 않은, 출발지로부터 가까운 정점부터 탐색

  #pagebreak()

  - 깊이 우선 탐색

  #algorithm({
    import algorithmic: *
    Function("Depth-First-Search", args: ($u$, $E$, $"visited"$), {
      Assign[$"visited"[u]$][*true*]
      For(cond: [*edge* $(u, v)$ *in* $E$], {
        If(cond: [*not* $"visited"[v]$], {
          Call("Depth-First-Search", [$v$, $E$, $"visited"$])
        })
      })
    })
  })

  #pagebreak()

  - 너비 우선 탐색

  #algorithm({
    import algorithmic: *
    Function("Breadth-First-Search", args: ($S$, $E$), {
      Assign[$Q$][#CallI("Make-Queue", [$S$])]
      Assign[$"visited"[u]$][*false*]
      Assign[$"visited"[u in S]$][*true*]
      While(cond: [$Q$ *is not empty*], {
        State[*pop* $u$ *from* $Q$]
        For(cond: [*edge* $(u, v)$ *in* $E$], {
        If(cond: [*not* $"visited"[v]$], {
          Assign[$"visited"[v]$][*true*]
          State[*push* $v$ *to* $Q$]
        })
      })
      })
    })
  })

  - 방문 체크 시점에 주의
]