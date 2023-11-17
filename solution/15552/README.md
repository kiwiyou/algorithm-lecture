# [15552 빠른 A+B](https://acmicpc.net/problem/15552)

- 입력과 출력을 빠르게 받아야 합니다.
- 언어별로 입출력을 빠르게 수행하는 방법을 정리해 두었습니다.
- 자세한 풀이는 코드를 참고하세요.

## C++

`std::cin`과 `std::cout`으로 입출력을 수행할 때 두 가지 문제가 있습니다.

1. `std::endl`을 출력하면 `std::cout`의 속도 저하가 있습니다. (아래 [버퍼링](#버퍼링) 참고)
2. `std::cin` 및 `std::cout`은 `std::scanf`와 `std::printf`와 동기화되므로
   속도 저하가 있습니다.
3. `std::cin`과 `std::cout`을 번갈아 가며 사용할 때, 반드시 입력 전 출력이
   모두 진행되도록 설정되어 있어 속도 저하가 있습니다.

1번 문제는 `std::endl` 대신 `"\n"`을 출력하는 것으로 해결할 수 있고,
2번 문제와 3번 문제는 `main` 함수 처음에 다음 두 줄을 추가하여 해결할 수 있습니다.
```cpp
std::ios_base::sync_with_stdio(false);
std::cin.tie(nullptr);
```

## Python

`input()` 함수로 많은 줄을 입력받는 것이 느립니다.
다음과 같이 `input()` 함수를 재정의하여 속도를 개선할 수 있습니다.
이때, 기존 `input()` 함수와 달리 문자열 끝에 `"\n"`이 붙을 수 있습니다.

```py
input = open(0, 'rb').readline
```

## Java

`System.in`으로 직접 입력받거나 `Scanner`을 사용하는 것이 느립니다.
`BufferedReader`을 사용하는 것이 좋습니다.

`System.out.println`으로 매번 출력하는 것은 느립니다. (아래 [버퍼링](#버퍼링) 참고)
`StringBuilder`에 모든 출력을 넣고 마지막에만 `System.out.print`를 호출하는 것이 좋습니다.


## Javascript

입력 자체가 쉽지 않아, 풀이 코드를 참고하기 바랍니다.

`console.log`로 매번 출력하는 것은 느립니다.
출력할 각 줄을 배열에 저장해 두고 마지막에 `console.log`로 출력하는 것이 좋습니다.

## 버퍼링

콘솔 및 파일에 문자를 쓰는 작업은 메모리에 쓰는 작업에 비해 느린 작업입니다.
따라서 매번 콘솔 및 파일에 쓰기보다는 메모리에 일정량을 쓴 후 한꺼번에 콘솔
및 파일에 쓰는 것이 빠릅니다. 이때 메모리를 **버퍼**,
메모리에 쓰는 것을 **버퍼링**이라고 합니다.