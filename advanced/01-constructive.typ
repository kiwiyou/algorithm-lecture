#import "@preview/cetz:0.1.2"
#import "@preview/algorithmic:0.1.0"
#import "../slide.typ"
#show: slide.style
#show link: slide.link
#show footnote.entry: slide.footnote

#let algorithm(..args) = text(font: ("linux libertine", "Pretendard"), size: 17pt)[#algorithmic.algorithm(..args)]
#let func(body) = text(font: ("linux libertine", "Pretendard"))[#smallcaps[#body]]

#align(horizon + center)[
  = 알고리즘 중급 세미나
  01: 해답의 구성

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.11.24.r1
  ]
]

#slide.slide([백트래킹])[
  - 특정한 조건을 만족하는 배치를 전부 탐색할 때 쓰는 기법

  - 한 수를 놓아 보고 안 되면 퇴각

  - 일반적으로 다음에 놓을 수와 지금까지 놓은 수에 대한 정보를 매개변수로 하는 재귀 함수

  #pagebreak()

  - 돈이 $M$원 있다. $N$개의 품목의 가격은 $C_i > 0$이고 만족도는 $P_i$이다. 최대 만족도는?

  #algorithm({
    import algorithmic: *
    Function("Max-Profit", args: ([$M$], [$N$], [$C$], [$P$]))
    Assign[$m$][0 #Ic[최대 만족도]]
    For(
      cond: [$i <- 0$ *until* $N$],
      If(
        cond: [$M >= C_i$],
        Assign([$p$], [$P_i +$ #CallI("Max-Profit", [$M - C_i$, $N$, $C$, $P$])]),
        Assign([$m$], $max(m, p)$)
      )
    )
    Return[$m$]
  })

  - $C_i = 1$이면 $N$개 품목마다 #func[Max-Profit($M - 1$)]을 호출: $cal(O)(N^M)$

  #pagebreak()

  - 최적화: $1 -> 2 -> 1$과 $1 -> 1 -> 2$는 같다!

  #algorithm({
    import algorithmic: *
    Function("Max-Profit", args: ([$M$], [$N$], [$C$], [$P$], [$i$]))
    If(
      cond: [$i = N$],
      Return[$0$]
    )
    Assign[$m$][0]
    Assign($c$)[0 #Ic[$i$번 품목 구매 개수]]
    While(
      cond: [$c times C_i <= M$],
      Assign([$p$], [$c times P_i +$ #CallI("Max-Profit", [$M - c times C_i$, $N$, $C$, $P$, $i + 1$])]),
      Assign([$m$], $max(m, p)$),
      Assign([$c$], $c + 1$),
    )
    Return[$m$]
  })

  - $attach(Pi, bl: N, br: M)$가지 $i$의 배치 중 *순서를 강제*\했으므로, $cal(O)(attach(H, bl: N, br: M))$

  #pagebreak()

  - 각 배치를 출력해 보자!
  #algorithm({
    import algorithmic: *
    Function("Max-Profit", args: ([$M$], [$N$], [$C$], [$P$], [$i$], [$R$]))
    If(
      cond: [$i = N$],
      Call("Print", [$R$]),
      Return[$0$],
    )
    State[...]
    While(
      cond: [$c times C_i <= M$],
      [*append* $i$ to $R$],
      Assign([$p$], [$c times P_i +$ #CallI("Max-Profit", [$M - c times C_i$, $N$, $C$, $P$, $i + 1$])]),
      [*remove* $i$ from $R$ #Ic[퇴각]],
      [...]
    )
    Return[$m$]
  })
]

#slide.slide([게임 이론])[
  - 주어진 게임에서 서로가 최선을 다할 때 승리 / 패배하는 사람은 누구이며, 필승 전략은 무엇인가?

  - 여기서 다루는 게임은 *조합론적 게임*
    - 2인이 번갈아 진행하며
    - 모든 정보가 공개되어 있고
    - 비기는 경우가 없는 게임

  - 두 플레이어가 같은 상황에 놓였다면 같은 선택을 함

  - 서로가 최선을 다한다는 조건을 최대한 이용해서 풀기

  #pagebreak()

  - 더 이상 진행할 수 없는 사람이
    - 패배: 일반 게임
    - 승리: 미제르 게임

  - 일반 게임의 경우, 더 이상 진행할 수 없는 상황을 만드는 것이 목표

  - 다음 수가 이기는 수인지 지는 수인지 확정할 수 있다면 이전 수도 확정

  - 더 이상 진행할 수 없는 상황으로부터 다이나믹 프로그래밍을 통해 각 상황에서의 승패를 확정 가능

  #pagebreak()

  - 배스킨라빈스 31
    - 31을 외치면 *패배*
    - 30을 외치고 31에서 상대가 패배 -> *승리* 가능
    - 30, 31을 외치고 패배 가능
    - ...

  - 다음 상황이 모두 (상대의) *패배*\라면 *승리*\하는 수
  
  - 다음 상황이 하나라도 (상대의) *승리*\라면 *패배*\하는 수

  - *승리*\하는 수가 하나라도 있으면 *승리*

  #pagebreak()

  #algorithm({
    import algorithmic: *
    Function("Is-First-Win", args: ([$n$], ))
    If(
      cond: [$n >= 31$],
      Return[*false*],
    )
    If(
      cond: [#CallI("Is-First-Win")[$n+1$] *or* #CallI("Is-First-Win")[$n+2$] *or* #CallI("Is-First-Win")[$n+3$]],
      Return[*false*],
    )
    Return[*true*]
  })

  #algorithm({
    import algorithmic: *
    Function("Is-First-Win-Iterative", args: ([$n$], ))
    Assign[table][${}$]
    Assign[table$[31]$, table$[32]$, table$[33]$][*false*]
    For(
      cond: [$i = 30$ *downto* $n$],
      Assign[table$[i]$][*not*(table$[i+1]$ *or* table$[i+2]$ *or* table$[i+3]$)]
    )
    Return[table[$n$]]
  })
]

#slide.slide([과제])[
  - #slide.problem("15649", "N과 M (1)")

  - #slide.problem("30242", "N-Queen (Easy)")

  - #slide.problem("14889", "스타트와 링크")

  - #slide.problem("1799", "비숍")

  - #slide.problem("9655", "돌 게임")

  - #slide.problem("2040", "수 게임")
]