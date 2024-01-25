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
  06: 최적화 문제의 접근 방법

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.01.25.r1
  ]
]

#slide.slide[그리디][
  - 문제가 단계별로 나누어져 있을 때, 각 단계의 최적을 통해 전체의 최적을 구하는 방법
  - $N$개의 정수 중 합이 가장 작은 세 수를 고르기
    - $cal(O)(N^3)$
    - $cal(O)(N^2)$
    - $cal(O)(N)$

  - $K$개 수 고르기
    - $cal(O)(N log N)$
    - $cal(O)(N)$

  #pagebreak()

  - $N$명의 사람이 한 화장실을 $A_(i)$초 이용할 때, 각 사람이 화장실을 다 쓰고 나올 때까지 걸린 시간의 합의 최솟값

  - $A_(i)$를 적절히 재배열한 수열 $B_(i)$에 대해서, 기다리는 시간의 합은

  $ N B_(1) + (N - 1) B_(2) + dots.c + 1 B_(N) $

  - 직관적으로?

  #pagebreak()

  - 교환 논법#super[Exchange Argument]

  - 최소가 되는 배치 $B$에서, 어떤 인접한 두 원소 $B_(i)$와 $B_(j)$가 $i < j$이고 $B_(i) >= B_(j)$를 만족한다고 가정

  - 필요한 시간은 $2B_(i) + B_(j)$

  - 순서를 바꾸면 $B_(i) + 2B_(j) <= 2B_(i) + B_(j)$

  - 앞쪽이 작도록 정렬하는 게 절대 손해가 되지 않음: 반드시 최적해 중 하나!

  #pagebreak()

  - 시작 시각이 $S_(i)$, 종료 시각이 $E_(i)$인 회의 $N$개가 하나의 회의실을 사용하려고 할 때, 진행 가능한 회의의 최대 수

  - 길이 $N$의 문자열이 `(`, `)`, `?`로 이루어져 있을 때, `?`를 모두 적당히 바꿔서 괄호 짝이 모두 맞도록 하기

  - $N$종류의 동전이 있을 때 $M$원을 거슬러 주기 위한 동전 수의 최솟값
]

#slide.slide[과제][
  - #slide.problem("29615", "알파빌과 베타빌")

  - #slide.problem("29767", "점수를 최대로")

  - #slide.problem("28353", "고양이 카페")
]

#slide.slide[재귀][
  - 자기 자신을 참조하는 것

  - 크기 $M$의 문제를 풀어서 크기 $N > M$의 문제를 풀 수 있는 경우

  - 주로 그리디로 풀기 어려운 문제를 해결

  - $n! = n times (n - 1)!$

  - $F_(n) = F_(n - 1) + F_(n - 2)$

  #pagebreak()

  - 원판이 $N$개인 하노이 탑을 옮기는 방법

  - $N - 1$개인 탑을 옮긴다
  
  - 원판을 옮긴다

  - $N - 1$개인 탑을 다시 옮긴다

  #pagebreak()

  - 함수의 동작 과정 대신 의미 혹은 반환값만을 생각해야 헷갈리지 않음

  #algorithm({
    import algorithmic: *
    Function([Hanoi], args: ($N$, $"from"$, $"to"$, $"mid"$), {
      If(cond: $N = 0$, {
        Return[]
      })
      Call([Hanoi], [$N$, $"from"$, $"mid"$, $"to"$])
      State[*print* $"from" -> "to"$]
      Call([Hanoi], [$N$, $"mid"$, $"to"$, $"from"$])
    })
  })

  - $cal(O)(2^N)$
]

#slide.slide[과제][
  - #slide.problem("1074", "Z")
]

#slide.slide[다이나믹 프로그래밍][
  - 문제를 재귀 형식으로 풀 때, 같은 인자를 주어 여러 번 실행하는 경우

  $
  f(n) &= f(n - 1) + f(n - 2) \
  f(2) &= 1 \
  f(1) &= 1
  $

  - $f(6)$을 구하기 위한 $f(1)$의 실행 횟수는?

  - -> 배열에 함숫값을 저장해 두자!

  #pagebreak()
  
  - $cal(O)(n)$

  #algorithm({
    import algorithmic: *
    Function([Fibonacci], args: ($n$, $"cache"$), {
      If(cond: [$"cache"$ *not contains* $n$], {
        Assign[$"cache"[n]$][
          #CallI("Fibonacci", [$n - 1$, $"cache"$]) + #CallI("Fibonacci", [$n - 2$, $"cache"$])
        ]
      })
      Return[$"cache"[n]$]
    })
  })

  #algorithm({
    import algorithmic: *
    Function([Fibonacci], args: ($n$, ), {
      Assign[$"cache"[1]$][$1$]
      Assign[$"cache"[2]$][$1$]
      For(cond: [$i$ *from* $3$ *upto* $n$], {
        Assign[$"cache"[i]$][$"cache"[i - 1]$ + $"cache"[i - 2]$]
      })
      Return[$"cache"$[n]]
    })
  })
]

#slide.slide[과제][
  - #slide.problem("14916", "거스름돈")

  - #slide.problem("9656", "돌 게임 2")

  - #slide.problem("9095", "1, 2, 3 더하기")
]
