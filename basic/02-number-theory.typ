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
  02: 정수론

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.11.25.r2
  ]
]

#slide.slide[합동식][
  - $N$개의 정수 $A_1, A_2, dots.c, A_N$이 있을 때, $A_1 + A_2 + dots.c + A_N$을 $3$으로 나눈 나머지를 구하자.

  - $A_i$가 최대 $10^18$이고, $N$이 최대 $10^5$

  - 합이 너무 커요 ㅠㅠ

  - $A_i$를 직접 더하지 않고 나머지만을 구할 수 없을까?

  #pagebreak()

  - $(A + B) mod 3 = (A mod 3 + B mod 3) mod 3$

  - 놀랍게도 이 성질은 $+$뿐만 아니라 $-$, $times$에도 적용되는데...

  - 놀랍게도 이 성질은 $3$이 아닌 모든 양의 정수에도 적용되는데...

  - 수식으로는 $A mod 3 = B mod 3 <=> A equiv B space (mod 3)$

  - 구현 시에는 모든 수, 모든 $+$, $-$, $times$ 시마다 나머지를 취하기

  - $mod N$에서 모든 수의 범위는 $0$ 이상 $N$ 미만으로 줄어든다!
]

#slide.slide[과제][
  - #slide.problem("9711", "피보나치")

  - #slide.problem("4375", "1")

  - #slide.problem("14928", "큰 수 (BIG)")

  - #slide.problem("27965", "N결수")
]

#slide.slide[소수 판정][
  - $1$과 자기 자신만을 양의 약수로 가지는 $2$ 이상의 정수

  - 양의 정수 $N$이 소수인지 판단하기

  - $1$부터 $N$까지 전부 나누면 $cal(O)(N)$

  - 조금 더 빠르게 할 수 없을까?

  #pagebreak()

  - $42$의 약수 $#text(fill: red)[1], #text(fill: green)[2], #text(fill: blue)[3], #text(fill: purple)[6], #text(fill: purple)[7], #text(fill: blue)[14], #text(fill: green)[21], #text(fill: red)[42]$
    - $1 times 42 = 42$
    - $2 times 21 = 42$
    - $3 times 14 = 42$
    - $6 times 7 = 42$

  - *앞쪽* 절반만 본다면 $cal(O)(sqrt(N))$

  #pagebreak()

  #columns(2)[
    #set text(size: 20pt)

    #algorithm({
      import algorithmic: *
      Function([Is-Prime], args: ([$N$], ))
      If(
        cond: $N = 1$,
        Return[*false*]
      )
      For(
        cond: [$i = 2$ *upto* #FnI[floor][#FnI[sqrt][$N$]]],
        If(
          cond: [$N equiv 0 space (mod i)$],
          Return[*false*]
        ),
      )
      Return[*true*]
    })

    - `sqrt`나 `floor`는 실수 오차를 동반하고, 느릴 수 있음

    #colbreak()

    #algorithm({
      import algorithmic: *
      Function([Is-Prime-2], args: ([$N$], ))
      If(
        cond: $N = 1$,
        Return[*false*]
      )
      Assign[$i$][$2$]
      While(
        cond: [$i^2 <= N$],
        If(
          cond: [$N equiv 0 space (mod i)$],
          Return[*false*]
        ),
        Assign[$i$][$i + 1$],
      )
      Return[*true*]
    })

    - 정수 연산은 정확
  ]

  #pagebreak()

  - $N$의 두 번째로 큰 소인수는 항상 $sqrt(N)$ 이하
  
  - 작은 약수부터 찾아 나눌 때, 나누어지지 않을 때까지 나눠보기

  #algorithm({
      import algorithmic: *
      Function([Factorize], args: ([$N$], ))
      Assign[$i$][$2$]
      While(
        cond: [$i <= N$],
        While(
          cond: [$N equiv 0 space (mod i)$],
          State[*print* $i$],
          Assign[$N$][$N slash i$],
        ),
        Assign[$i$][$i + 1$],
      )
      If(
        cond: $N eq.not 1$,
        State[*print* $N$],
      )
    })
]

#slide.slide[과제][
  - #slide.problem("24039", "2021은 무엇이 특별할까?")
  
  - #slide.problem("27065", "2022년이 아름다웠던 이유")

  - #slide.problem("28138", "재밌는 나머지 연산")
]

#slide.slide[에라토스테네스의 체][
  - $N$ 이하의 소수를 모두 구해야 하는 경우 $cal(O)(N sqrt(N))$

  - 중복 연산이 너무 많아요

  - *약수를 세는 것보다 배수를 세는 것이 빠르다*

  #pagebreak()

  - $2$ 이상 $N$ 이하의 각 정수가 소수인지를 배열에 저장

  - 처음에는 모든 수가 소수라고 가정

  - 가장 작은 소수를 하나 찾으면, 그 수의 배수는 소수가 아니라고 확정

  - 시간복잡도는 $cal(O)(N log log N)$

  #pagebreak()

  #h(0pt)

  #algorithm({
    import algorithmic: *
    Function([Find-Primes], args: ([$N$], ))
    Assign[isPrime$[2..N]$][*true*]
    Assign[primeList][${}$]
    For(
      cond: [$i = 2$ *upto* $N$],
      If(
        cond: [isPrime$[i]$],
        State[*add* $i$ *to* primeList],
        Assign[$j$][$2 times i$],
        While(
          cond: [$j <= N$],
          Assign[isPrime$[j]$][*false*],
          Assign[$j$][$j + i$]
        ),
      )
    )
    Return[primeList]
  })

  #pagebreak()

  - 체에 `true`, `false` 대신 그 수의 소인수를 넣는다면?

  #algorithm({
    import algorithmic: *
    Function([Find-Prime-Factors], args: ([$N$], ))
    Assign[primeFactor$[i]$][$i$]
    For(
      cond: [$i = 2$ *upto* $N$],
      If(
        cond: [primeFactor$[i] = i$],
        Assign[$j$][$2 times i$],
        While(
          cond: [$j <= N$],
          Assign[primeFactor$[j]$][$i$],
          Assign[$j$][$j + i$]
        ),
      )
    )
    Return[primeFactor]
  })
]

#slide.slide[과제][
  - #slide.problem("1929", "소수 구하기")

  - #slide.problem("2421", "저금통")

  - #slide.problem("16563", "어려운 소인수분해")
]