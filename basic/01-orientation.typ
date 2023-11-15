#import "@preview/cetz:0.1.2"
#import "@preview/algorithmic:0.1.0"
#import "../slide.typ"
#show: slide.style
#show link: slide.link
#show footnote.entry: slide.footnote

#let algorithm(..args) = text(font: ("linux libertine", "Pretendard") ,size: 17pt)[#algorithmic.algorithm(..args)]

#align(horizon + center)[
  = 알고리즘 기초 세미나
  OT: 알고리즘 문제를 푸는 방법

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.11.15.r1
  ]
]

#slide.slide([알고리즘 문제의 의도])[
  - 시험자가 얼마나 원하는 기능을 잘 구현할 수 있는지 시험

  #align(horizon + center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(
        stroke: (thickness: 2pt),
        mark: (size: 0.5, angle: 80deg),
      )
      content((0, 0), align(center)[기능 \ = 여러분의 코드], name: "code", padding: 1, frame: "rect")
      content((rel: (-3, 0), to: "code.left"), [입력], anchor: "right", name: "input")
      content((rel: (3, 0), to: "code.right"), [출력], anchor: "left", name: "output")
      line((rel: (0.5, 0), to: "input.right"), (rel: (-0.5, 0), to: "code.left"), mark: (end: ">"))
      line((rel: (0.5, 0), to: "code.right"), (rel: (-0.5, 0), to: "output.left"), mark: (end: ">"))
    })
  ]
  #pagebreak()
  - "잘" 구현한다는 것은?
    1. 마감 기한 안에 코드를 짤 수 있어야 함

    2. 기능이 맡은 일을 정확하게 수행해야 함

    3. 기능이 적당한 시간 안에 돌아가야 함
  
  #align(horizon + center)[
    #cetz.canvas({
      import cetz.draw: *
      set-style(
        stroke: (thickness: 2pt),
        mark: (size: 0.5, angle: 80deg),
      )
      content((0, 0), [맡은 일], name: "task", anchor: "right", padding: 0.5)
      content((4, 1), [알고리즘을 응용하는 사고력 문제], anchor: "left", name: "think", padding: 0.5)
      content((4, -1), [알고리즘을 사용하는 실 기능 구현 문제], anchor: "left", name: "impl", padding: 0.5)
      line("task.right", "think.left", mark: (end: ">"))
      line("task.right", "impl.left", mark: (end: ">"))
      content(("task.right", .5, "think.left"), text(size: 0.8em)[대회], angle: "think.left", padding: 0.2, frame: "rect", fill: white, stroke: none)
      content(("task.right", .5, "impl.left"), text(size: 0.8em)[코테], angle: "impl.left", padding: 0.2, frame: "rect", fill: white, stroke: none)
    })
  ]

  #pagebreak()

  - 구현력은 문제를 많이 푸는 경험으로 터득
    - #link("https://acmicpc.net/")[백준 온라인 저지]
    - #link("https://programmers.co.kr/")[프로그래머스]

  - 출제되는 문제의 유형을 파악하고 유형별 문제 해결 방법을 숙지
]

#slide.slide([알고리즘 문제의 접근 방식])[
  - 문제 상황을 알기 쉬운 형태로 정리

    -> 수식화, 알고 있는 문제로 변형

  - 문제에서 어느 정도로 효율적인 풀이를 원하는지 파악

    -> 시간복잡도 분석

  - 풀이가 비효율적이라면 어느 부분을 개선할 수 있는지 파악

    -> 필요없는 계산을 최대한 줄이기
]

#slide.slide([시간복잡도 분석])[
  - 현대 상용 컴퓨터는 1초에 수억#super[10#super[8]] 번의 단위 연산#super[unit operation]이 가능#footnote()[인터프리트되는 언어의 경우 단위 연산이 없는 것과 마찬가지이므로 이보다 훨씬 적은 수의 연산을 수행할 수 있다.]

  - 코드가 조금만 복잡해져도 단위 연산의 횟수를 정확하게 세는 것이 어려움

  - 입력 크기에 따라 단위 연산의 횟수가 얼마나 빠르게 증가하는지만 계산

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function("Max-Sum-Pair", args: ([$A$], ))
    Assign[$m$][0]
    For(
      cond: [$i <- 0$ *until* $"len"(A)$],
      For(
        cond: [$j <- 0$ *until* $i$],
        Assign[$m$][$max(m, A[i] + A[j])$]
      )
    )
    Return[$m$]
  })

  - 덧셈과 $max$ 연산은 모두 합쳐 $N^2 + N$번 일어나지만 $O(N^2)$으로 표기

  - $N = 5000$이라면 $N^2 = 2.5 times 10^7$이므로 $1$초 시간제한 내에 실행될 것

  - $N = 10^5$이라면 $N^2 = 10^10$이므로 $1$초 시간제한 내에 실행되지 않을 것

  - 정확한 계산이 아니므로 드물게 시간이 안 맞을 수 있음
]

#slide.slide([빠른 입출력])[
  - 백준 온라인 저지의 경우 미리 준비된 입력 파일들을 프로그램에 전달하고 프로그램의 출력을 출력 파일들과 비교

  - 콘솔 입출력 기능을 사용하면 되지만, 내부 동작 방식으로 인해 문제가 생길 수 있음
]

#slide.slide([과제])[
  - #slide.problem("15552", "빠른 A+B")
]