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
  03: 그래프에서의 다이나믹 프로그래밍

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.12.08.r1
  ]
]

#slide.slide[방향 비순환 그래프][
  - 방향이 있고#super[Directed], 순환이 없는#super[Acyclic] 그래프

  - 순서 관계를 일반화한 것?

  #align(center + horizon)[
    #text(size: 20pt)[
      #cetz.canvas({
        import cetz.draw: *

        let r = 0.75cm
        set-style(
          content: (
            frame: "circle",
            padding: 0.2,
          ),
          circle: (
            radius: r
          ),
          line: (
            mark: (
              end: ">",
              size: 0.2,
              fill: black,
            )
          ),
        )
        let connect(a, b) = line((a + ".center", r, b + ".center"), (b + ".center", r, a + ".center"))

        group({
          content((0, 0), [A], name: "A")
          content((3, 0), [B], name: "B")
          content((6, 0), [C], name: "C")
          content((9, 0), [D], name: "D")
          content((0, -2), [E], name: "E")
          content((9, -2), [F], name: "F")
          connect("A", "B")
          connect("B", "C")
          connect("C", "D")
          connect("E", "B")
          connect("C", "F")
          connect("B", "F")
        }, name: "O")
        
        content((rel: (0, -0.5), to: "O.bottom"), [DAG의 예], frame: none)

        group({
          set-origin((12, 0))
          content((0, 0), [A], name: "A")
          content((3, 0), [B], name: "B")
          content((6, 0), [C], name: "C")
          content((9, 0), [D], name: "D")
          content((0, -2), [E], name: "E")
          content((9, -2), [F], name: "F")
          connect("A", "B")
          connect("B", "C")
          connect("C", "D")
          connect("E", "B")
          connect("B", "F")
          connect("F", "E")
          let mid = ("E.center", 0.5, "F.center")
          set-style(
            line: (
              mark: (
                end: none
              ),
              stroke: (
                paint: red,
                thickness: 0.1cm,
              ),
            ),
          )
          line((rel: (-0.2, -0.2), to: mid), (rel: (0.2, 0.2), to: mid))
          line((rel: (-0.2, 0.2), to: mid), (rel: (0.2, -0.2), to: mid))
        }, name: "X")

        content((rel: (0, -0.5), to: "X.bottom"), [DAG가 아닌 예], frame: none)
      })
    ]
  ]
]

#slide.slide[위상 정렬][
  - 정점을 순서대로 나열하는 방법

  - 순서가 정의되지 않은 두 정점의 경우 어떤 순서라도 가능

  #align(center + horizon)[
    #text(size: 20pt)[
      #cetz.canvas({
        import cetz.draw: *

        let r = 0.75cm
        set-style(
          content: (
            frame: "circle",
            padding: 0.2,
          ),
          circle: (
            radius: r
          ),
          line: (
            mark: (
              end: ">",
              size: 0.2,
              fill: black,
            )
          ),
        )
        let connect(a, b) = line((a + ".center", r, b + ".center"), (b + ".center", r, a + ".center"))
        group({
          content((0, 0), [A], name: "A")
          content((3, 0), [B], name: "B")
          content((6, 0), [C], name: "C")
          content((9, 0), [D], name: "D")
          content((0, -2), [E], name: "E")
          content((9, -2), [F], name: "F")
          connect("A", "B")
          connect("B", "C")
          connect("C", "D")
          connect("E", "B")
          connect("C", "F")
          connect("B", "F")
        }, name: "g")
        group(anchor: "top-right", {
          set-origin((rel: (0, -2), to: "g.bottom"))
          content((-6, 0), [A], name: "A")
          content((-4, 0), [E], name: "E")
          content((-2, 0), [B], name: "B")
          content((0, 0), [C], name: "C")
          content((2, 0), [D], name: "D")
          content((4, 0), [F], name: "F")
          connect("A", "E")
          connect("E", "B")
          connect("B", "C")
          connect("C", "D")
          connect("D", "F")
        }, name: "s1")
        group(anchor: "top-left", {
          set-origin((rel: (0, -2), to: "g.bottom"))
          content((-4, 0), [A], name: "A")
          content((-2, 0), [B], name: "B")
          content((0, 0), [C], name: "C")
          content((2, 0), [E], name: "E")
          content((4, 0), [F], name: "F")
          content((6, 0), [D], name: "D")
          connect("A", "B")
          connect("B", "C")
          connect("C", "E")
          connect("E", "F")
          connect("F", "D")
        }, name: "s2")

        set-style(
          line: (
            mark: (
              end: ">"
            )
          )
        )

        line((rel: (-5, -0.5), to: "g.bottom"), (rel: (0, 0.5), to: "s1.top"))
        line((rel: (5, -0.5), to: "g.bottom"), (rel: (0, 0.5), to: "s2.top"))
      })
    ]
  ]

  #pagebreak()

  - 진입 차수#super([indegree]): 정점을 가리키는 화살표의 개수

  - 진입 차수가 0인 정점을 아무거나 방문

  - 정점을 방문할 때마다 그 정점에서 출발하는 화살표를 모두 제거

  - 큐와 스택 모두 이용 가능

  #pagebreak()

  #algorithm({
    import algorithmic: *

    Function("Topological-Sort", args: ($V$, $E$), {
      Assign[$"indegree"[u]$][$0$]
      For(
        cond: [$(u, v)$ *in* $E$],
        Assign[$"indegree"[v]$][$"indegree"[v] + 1$]
      )
      Assign[$Q$][${}$]
      For(
        cond: [$u$ *in* $V$],
        If(
          cond: $"indegree"[u] = 0$,
          State[*add* $u$ to $Q$]
        )
      )
      Assign[$"order"$][${}$]
      While(
        cond: [$Q$ is not empty],
        {
          State[*pop* $u$ from $Q$]
          State[*append* $u$ to $"order"$]
          For(
            cond: [$(u, v)$ *in* $E$],
            {
              Assign[$"indegree"[v]$][$"indegree"[v] - 1$]
              If(
                cond: $"indegree"[v] = 0$,
                State[*add* $u$ to $Q$]
              )
            }
          )
        }
      )
      Return[$"order"$]
    })
  })
]

#slide.slide[DAG에서의 다이나믹 프로그래밍][
  - 위상 정렬 후 bottom-up으로 접근하면 1차원 다이나믹 프로그래밍과 동일

  - 간선을 역방향으로 놓은 후 DFS
    - 동일 정점을 여러 번 방문하지 않도록 주의

  - 간선이 모두 부모 방향인 트리는 DAG
]

#slide.slide[과제][
  - #slide.problem("25168", "게으른 아리를 위한 접종 계획")

  - #slide.problem("24526", "전화 돌리기")

  - #slide.problem("26159", "트리와 수열")
]