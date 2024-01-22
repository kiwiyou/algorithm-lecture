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
  06: 고급 정수론

  #text(size: 0.8em)[
    연세대학교 전우제#super[kiwiyou] \
    2023.01.22.r1
  ]
]

#slide.slide[분할 정복을 이용한 거듭제곱][
  - $a^b$를 계산하기

  - $b = x_(1)2^0 + x_(2)2^1 + x_(3)2^2 + x_(4)2^3 + dots.c$

  - $a^b = a^(x_(1)) times a^(2x_(2)) times a^(4x_(3)) times a^(8x_(4)) times dots.c$
  
  - $cal(O)(log b)$번의 곱셈으로 충분

  - 덧셈에도 응용 가능

  #pagebreak()

  - 비트 연산을 이용

  #algorithm({
    import algorithmic: *
    Function("Power", args: ($a$, $b$), {
      Assign[$r$][$1$]
      While(cond: $b > 0$, {
        If(cond: $b "bitand" 1 = 1$, {
          Assign[$r$][$r times a$]
        })
        Assign[$a$][$a times a$]
        Assign[$b$][$"rshift"(b, 1)$]
      })
      Return[$r$]
    })
  })

  #pagebreak()

  - 행렬곱을 이용한 선형 점화식의 계산

  $ a_(n+2) = 3a_(n+1) + 2a_(n) + 1 $
  $ mat(3, 2, 1; 1, 0, 0; 0, 0, 1) mat(a_(n+1); a_(n); 1) = mat(a_(n+2); a_(n+1); 1) $
  $ mat(3, 2, 1; 1, 0, 0; 0, 0, 1)^n mat(a_(2); a_(1); 1) = mat(a_(n+2); a_(n+1); 1) $

  #pagebreak()

  - 행렬곱에 $cal(O)(k^3)$ 시간이 걸리므로 $cal(O)(k^3 log n)$

  - 슈트라센 알고리즘: 행렬곱은 $cal(O)(k^2.8)$ 정도에 계산 가능

  - 키타마사법: $cal(O)(k log k log n)$

  #pagebreak()

  - Functional Graph: 진출차수가 1인 그래프

  - 어떤 정점 $v$에서 그래프를 따라 $k$번 이동한 위치를 구하시오.

  - $cal(O)(N log k)$
]

#slide.slide[모듈러 곱셈 역원][
  - 연산 $circle.tiny$의 항등원 $e$: $a circle.tiny e = e circle.tiny a = a$

  - $a$의 역원 $a^(-1)$: $a circle.tiny a^(-1) = a^(-1) circle.tiny a = e$

  - $a$의 법 $N$에 대한 곱셈 역원 $a^(-1)$: $a times a^(-1) equiv 1 space (mod N)$

  - $exists x in bb(Z): a times a^(-1) + N times x = 1$

  #pagebreak()

  - 페르마의 소정리: $a^(p-1) equiv a space (mod p)$

  - $a^(p-2) times a = a^(p-1) equiv 1 space (mod p)$

  - $a^(-1) equiv a^(p-2) space (mod p)$

  #pagebreak()

  - 확장 유클리드 호제법

  - $a x + b y = gcd(a, b)$를 만족하는 두 정수 $x$, $y$

  $
  a times 1 + b times 0 = a space.en& a times 0 + b times 1 = b \
  a times 0 + b times 1 = b space.en& a times 1 + b times (-q) = c && space dots.c space (a = b q + c) \
  a times 1 + b times (-q) = c space.en& a times (-1) + b times (1 + q') = d && space dots.c space (b = c q' + d) \
  dots.v \
  a x + b y = gcd(a, b) space.en& a x' + b y' = 0
  $

  - 유클리드 호제법과 같은 $cal(O)(log max(a, b))$
]