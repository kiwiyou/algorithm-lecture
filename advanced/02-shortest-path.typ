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
  02: 그래프의 최단거리

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.11.30.r1
  ]
]

#slide.slide(
  [누적 합],
)[
  - 구간의 합을 합의 차로 구하는 테크닉

  - $S_i = a_1 + a_2 + dots.c + a_i $일 때, $a_i + a_(i+1) + dots.c + a_j = S_j - S_(i-1)$

  - $a_i$가 변하지 않을 때 구간의 합을 $cal(O)(1)$에 구함
]

#slide.slide(
  [2차원 누적 합],
)[
  - 직사각형의 합을 구하는 테크닉

  #[
    #show math.equation: set text(size: 22pt)
    $
      S_(r, c) = sum mat(
        a_(1, 1), a_(1, 2), ..., a_(1, c);
        a_(2, 1), a_(2, 2), ..., a_(2, c);
        dots.v, dots.v, dots.down, dots.v;
        a_(r, 1), a_(r, 2), ..., a_(r, c);
      )
    $

    $ sum mat(
      a_(t, l), a_(t, l+1), ..., a_(t, r);
      a_(t+1, l), a_(t+1, l+1), a_(t+1, r);
      dots.v, dots.v, dots.down, dots.v;
      a_(b, l), a_(b, l+1), ..., a_(b, r);
    ) = S_(b, r) - S_(t - 1, r) - S_(b, l - 1) + S_(t - 1, l - 1) $
  ]

  #pagebreak()

  - 직사각형을 4분할한 뒤 생각

  #align(center + horizon)[
    #show math.equation: set text(size: 20pt)
    #cetz.canvas({
      import cetz.draw: *
      let size = 6

      line((0, -.4), (size, -.4))
      line((-.4, 0), (-.4, size))

      content((0, -.7), $0$, anchor: "top")
      content((size/2, -.7), $l$, anchor: "top")
      content((size, -.7), $r$, anchor: "top")
      content((-.7, size), $0$, anchor: "top-right")
      content((-.7, size/2), $t$, anchor: "right")
      content((-.7, 0), $b$, anchor: "right")

      rect((0, 0, 0), (size, size, 0), fill: rgb(100%, 0, 0, 25%))
      rect((0, 0, 1), (size/2, size, 1), fill: rgb(0, 100%, 0, 25%))
      rect((0, size/2, 2), (size, size, 2), fill: rgb(0, 0, 100%, 25%))
      rect((0, size/2, 3), (size/2, size, 3), fill: rgb(0, 0, 0, 25%))

      set-style(line: (stroke: (dash: "dashed")))
      line((0, 0, 0), (0, 0, 1))
      line((size/2, 0, 0), (size/2, 0, 1))
      line((size/2, size/2, 0), (size/2, size/2, 3))
      line((size, size/2, 0), (size, size/2, 2))
      line((0, size/2, 0), (0, size/2, 3))
      line((0, size, 0), (0, size, 3))
      line((size/2, size, 0), (size/2, size, 3))
      line((size, size, 0), (size, size, 2))

      content((size*3/4, size/4), $S_(b, r)$, anchor: "center")
      content((size/4+.5, size/4+.4), $S_(b, l - 1)$, anchor: "center")
      content((size*3/4+1, size*3/4+1), $S_(t - 1, r)$, anchor: "center")
      content((size/4+1.5, size*3/4+1.5), $S_(t - 1, l - 1)$, anchor: "center")
    })
  ]

  #pagebreak()

  - $S_(r, c)$ 구하는 법

  #align(center + horizon)[
    #cetz.canvas({
      import cetz.draw: *
      let size = 8
      let count = 5
      let step = size / count
      grid((-size/2 - .5, 0), (rel: (size, size)), step: step, name: "right")
      set-style(
        line: (
          stroke: (
            paint: red,
            thickness: 4pt,
          ),
          mark: (
            fill: red,
            end: ">",
            size: 0.3,
            angle: 75deg,
          ),
        ),
      )
      let i = 0
      while i < 5 {
        line((rel: (step/2, i * step + step/2), to: "right.bottom-left"), (rel: (-step/2, i * step + step/2), to: "right.bottom-right"))
        i += 1
      }

      grid((size/2 + .5, 0), (rel: (size, size)), step: step, name: "down")
      set-style(
        line: (
          stroke: (
            paint: blue,
          ),
          mark: (
            fill: blue,
          ),
        ),
      )
      let i = 0
      while i < 5 {
        line((rel: (i * step + step/2, -step/2), to: "down.top-left"), (rel: (i * step + step/2, step/2), to: "down.bottom-left"))
        i += 1
      }
    })
  ]
]

#slide.slide[과제][
  - #slide.problem("11660", "구간 합 구하기 5")

  - #slide.problem("25682", "체스판 다시 칠하기 2")

  - #slide.problem("14846", "직사각형과 쿼리")
]

#slide.slide[플로이드-워셜][
  - 모든 두 정점 간 최단 경로 (APSP)

  - 도달성(추이 폐포)을 모두 구할 수 있음
  
  - 양수, 음수 가중치 모두 가능

  - 음수 사이클의 존재를 판단 가능

  #pagebreak()

  - 인접행렬 기반

  - 매번 각 정점이 양쪽으로 잇는 경로를 탐색 후 최단거리 갱신 (Relaxation)

  - 정점 $V$개, 정점과 연결된 양쪽 점을 찾는 데 $cal(O)(V^2)$

  - $cal(O)(V^3)$

  - 음수 사이클이 있다면 $u -> u$ 최단거리가 갱신

  - 오버플로에 주의

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function("Floyd-Warshall", args: ($A$, ), {
      For(
        cond: [$"via"$ *in* $V$], {
          For(
            cond: [$u$ *in* $V$], {
              For(
                cond: [$v$ *in* $V$],
                If(
                  cond: $A[u][v] > A[u]["via"] + A["via"][v]$,
                  Assign[$A[u][v]$][$A[u]["via"] + A["via"][v]$]
                )
              )
            }
          )
          For(
            cond: [$u$ *in* $V$], {
              If(
                cond: $A[u][u] < 0$,
                State[*report* negative cycle]
              )
            }
          )
        }
      )
    })
  })

  - $A[u][v]$는 $u -> v$ 간선의 가중치 또는 $infinity$

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function("Transitive-Closure", args: ($A$, ), {
      For(
        cond: [$"via"$ *in* $V$], {
          For(
            cond: [$u$ *in* $V$], {
              For(
                cond: [$v$ *in* $V$],
                If(
                  cond: [$A[u]["via"]$ *and* $A["via"][v]$],
                  Assign[$A[u][v]$][*true*]
                )
              )
            }
          )
        }
      )
    })
  })

  - $A[u][v]$는 $u -> v$ 간선이 있으면 `true`, 없으면 `false`
]

#slide.slide[과제][
  - #slide.problem("1613", "역사")

  - #slide.problem("11562", "백양로 브레이크")
]

#slide.slide[벨만-포드][
  - 출발점 $s$에서 시작해서 모든 정점으로 끝나는 최단 경로 (SSSP)

  - 양수, 음수 가중치 모두 가능

  - 음수 사이클의 존재를 판단 가능

  #pagebreak()

  - $s$를 제외한 모든 정점까지의 거리 $D[u]$를 무한대로 놓고 시작

  - $|V|-1$번, 모든 간선을 이용해 Relax

  - 모든 최단경로는 $|V|-1$개의 간선으로 이루어짐

  - 음수 사이클이 있다면 $|V|$번째에 Relax

  - $|V|-1$번 모든 간선을 확인하므로 총 $cal(O)(V E)$

  #pagebreak()

    #algorithm({
      import algorithmic: *
      Function("Bellman-Ford", args: ($V$, $E$, $s$), {
        Assign[$D[v]$][*inf* for all $v in V$]
        Assign[$D[s]$][$0$]
        For(
          cond: [$|V| - 1$ times], {
            For(
              cond: [$(u, v, w)$ *in* $E$], 
              If(
                cond: [$D[v] > D[u] + w$],
                Assign[$D[v]$][$D[u] + w$]
              )
            )
          }
        )
        For(
          cond: [$(u, v, w)$ *in* $E$], 
          If(
            cond: [$D[v] > D[u] + w$],
            State[*report* negative cycle]
          )
        )
        Return[$D$]
      })
    })
]

#slide.slide[과제][
  - #slide.problem("1865", "웜홀")
]

#slide.slide[데이크스트라][
  - 출발점 $s$에서 시작해서 모든 정점으로 끝나는 최단 경로 (SSSP)

  - $0$ 이상의 가중치에서만 사용 가능

  - $D[u]$가 최단거리라면 더 Relax되지 않음

  - $s -> v -> w$가 최단거리라면 $s -> v$ 또한 최단거리

  #pagebreak()

  - $s$를 제외한 모든 정점까지의 거리 $D[u]$를 무한대로 놓고 시작

  - 집합 $Q$: 아직 최단거리가 결정되지 않은 정점
    - 처음에 $Q = V$

  - $Q$에서 $D[u]$가 가장 작은 정점 $u$를 뽑음

  - $u$와 연결된 각 정점 $v$를 Relax

  - $Q$에서 $u$를 찾는 데 총 $cal(O)(V^2)$, Relax에 쓰이는 간선 확인 총 $cal(O)(E)$

  - $cal(O)(V^2+E)$?

  #pagebreak()

  - 이진 힙 (#sym.in 우선순위 큐)
    - 삽입에 $cal(O)(log N)$
    - 최소 원소 확인에 $cal(O)(1)$
    - 최소 원소 삭제에 $cal(O)(log N)$
  
  - $cal(O)(E)$번의 Relax마다 힙에 삽입하므로 $cal(O)(E log E)$
  
  - 그만큼 삭제가 일어나므로 $cal(O)(E log E)$

  #pagebreak()

  - 이론적인 최소 시간복잡도 $cal(O)(E + V log V)$ (구현이 복잡하여 느림)

  - 피보나치 힙
    - 삽입에 $cal(O)(log N)$
    - 최소 원소 삭제에 $cal(O)(log N)$
    - 우선순위 변경에 $cal(O)(1)$

  - $cal(O)(E)$번의 Relax마다 우선순위를 변경하므로 $cal(O)(E)$

  - 힙에는 처음에 $cal(O)(V)$개의 원소가 들어가고 $cal(O)(V)$번 삭제가 일어나므로 $cal(O)(V log V)$

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function("Dijkstra", args: ($V$, $E$, $s$), {
      Assign[$D[v]$][*inf* for all $v in V$]
      Assign[$D[s]$][$0$]
      Assign[$Q$][${ (s, D[s]) }$ #Ic[Binary Heap]]
      While(
        cond: [$Q$ is not empty], {
          State[*remove* $(u, d)$ from $Q$ with minimum $d$]
          If(
            cond: $d > D[u]$,
            State[*continue*]
          )
          For(
            cond: [$(u, v, w)$ in $E$], {
              If(
                cond: $D[v] > D[u] + w$, {
                  Assign[$D[v]$][$D[u] + w$]
                  State[*insert* $(v, D[v])$ into $Q$]
                }
              )
            }
          )
        }
      )
      Return[$D$]
    })
  })
  - $d > D[u]$ 체크가 빠지면 $cal(O)(V^2 log E)$!
]

#slide.slide[과제][
  - #slide.problem("14284", "간선 이어가기 2")

  - #slide.problem("25636", "소방차")

  - #slide.problem("28131", "K-지폐")
]