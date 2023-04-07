# Compiler
컴파일러는 소스코드를 기계어로 바꿔주는 역할을 한다</br>
이 때 구문분석 -> 최적화 -> 코드생성 -> 링킹 의 과정이 진행되며</br>
소스코드는 Tokenizer, Lexer, Parser를 차례대로 지나가며</br>
구문분석을 진행하게 되는데, 해당 과정에 대해 정리해보고자 한다</br>

> 2020, NaverBoostCamp의 자료들을 많이 참고하였습니다

## 1. Tokenizer
</br>
Tokenizer 는 말 그대로 어떤 구문을 토큰화 하는 역할을 한다</br>
여기서 토큰이란 어휘 분석의 작은 단위를 뜻하며 단어, 단어구, 문자열 등 의미있는 단위로 정해진다</br>
토큰은 어떤 요소들을 구조적으로 표현할 수 있도록 도와준다</br>
따라서, 어떤 명령어가 들어오면 해당 명령어를 잘라서 토큰들의 리스트로 반환해준다</br>

## 2. Lexer

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FumKpX%2FbtrJ16Cdxcl%2FeIkfIxv61fls2rqTwJ62cK%2Fimg.png" width = 350>
</br>
Lexer는 Tokenizer 로 인해 쪼개진 토큰들의 의미를 분석하는 역할을 한다</br>
Tokenizer를 거치며 의미있는 단위로 쪼개지고,</br>
Lexer를 거치며 토큰의 유형을 분석하는 과정을 통틀어 Lexical Analyze라고 한다</br>

return 이라는 명령어를 분석하는 과정을 예로 들어보자</br>
</br>

> ex) return A 명령어 분석
> - return A라는 단어에서 자체는 아무 의미도 가지지 않음
> - Tokenizer를 거치며 return과 A라는 의미있는 단어가 됨 -> 토큰화
> - Lexer를 거치며 return 토큰은 무언가를 반환하라는 명령어구나! 라고 의미를 분석
> - Lexer를 거치며 A 토큰은 무언가를 참조하는 변수의 주소를 나타낸다! 라고 의미를 분석
> - 해당 토큰은 {type: 명령어, value: "return", child: []} 와 같은 식으로 의미가 분석되어 Parser에게 전달된다

## 3. Parser

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcbbFbv%2FbtrJ4Fp9j1J%2F0MxqZhfxrmnDYEs5NoClKk%2Fimg.png" width = 350>
</br>
Parser는 Lexical Analyze된 데이터를 구조적으로 나타낸다</br>
데이터가 올바른지 검증하는 역할도 수행하는데, 이를 통틀어 Syntax Analyze라고 한다</br>
</br>
만약 실제로 Tokenizer, Lexer, Parser 개념을 이용하여 무언가를 구현해볼 생각이라면,</br>
Parser가 태스크를 수행하는 부분에서 무언가 올바르지 않은 데이터가 발견되었다면</br>
Error를 던지는 식으로 에러 핸들링이 필요하다</br>
Parser에 의해 도출된 결과는 AST(Abstract Syntax Tree) 형태로 생성된다</br>
</br>

## 4. AST (Abstract Syntax Tree)
AST는 이름 그대로 Tokenizer, Lexer, Parser 과정을 거치며 분석된 구문을 트리의 형태로 나타내는 자료구조다</br>
분석된 소스를 컴퓨터가 이해할 수 있는 구조로 변경시킨 트리라고 보면 된다</br>
AST는 다음과 같은 구조로 이루어져 있다</br>

<img src = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuZsby%2FbtrJ1Ia03Rm%2FhRP0K90p4upYE4XKfcfoq0%2Fimg.png" width = 350>

## 5. 예시

### 예시 1)
```C
// - Input
printf("Hello World");

// - Tokenizer : 의미있는 단위로 분리 (토큰화)
["printf", "(", "Hello World", ")", ";"]

// - Lexer : 주어진 토큰의 의미 분석
<id, printf>
<punctuation, (>
<literal, "Hello World">
<punctuation, )>
<punctuation, ;>

// - Parser : 분석된 데이터 검증 및 AST 구조화
{
    type: punctuation,
    value: printf,
    child: [
        {
            type: literal,
            value: "Hello World",
            child: []
        }
    ]
}
```

위의 예시는 정상적으로 구문 분석을 완료했을때를 보여준다</br>
AST 에서는 괄호나 세미콜론과 같은 정보들은 생략하고 </br>
소스코드에서 필요한 정보들만 추려내어 트리형태로 나타낸 것을 알 수 있다</br>
</br>
Abstract 라는 단어가 들어간 이유는</br>
소스코드의 불필요한 정보는 제외하고 핵심 데이터들만을 이용해 트리를 구성하기 때문이다</br>

---

### 예시 2)

```C
// - Input
printf("Wrong Syntax")

// - Tokenizer : 의미있는 단위로 분리 (토큰화)
["printf", "(", "Wrong Syntax", ")"]

// - Lexer : 주어진 토큰의 의미 분석
<id, printf>
<punctuation, (>
<literal, "Hello World">
<punctuation, )>

// - Parser : 분석된 데이터 검증 및 AST 구조화
Compile Error - missing semicolon
```

위의 예시에서는 잘못된 코드를 분석하는 과정을 나타낸다</br>
Tokenizer 와 Lexer 는 의미있는 단위로 소스를 분리하고</br>
의미를 분석하는 역할만 할 뿐, 해당 소스가 유효한지 아닌지는 검증하지 않는다</br>
</br>
실제 과정은 보다 복잡한 방식으로 이뤄지겠지만</br>
검증은 Parser에서 진행되기 때문에, Parser에서 컴파일 에러를 던져줄 것이다</br>
컴파일 에러의 대부분은 위와 같이 Parser에서 데이터를 AST로 구조화하지 못하여 던져주는 에러일 확률이 높다</br>

## 6. 참고

+ [프로그래밍 언어 제작기](https://medium.com/teamnexters/koa%ED%8C%80-%EA%B0%9C%EB%B0%9C%EC%9E%90-%EC%A3%BC%EA%B0%84-%EB%AF%B8%EC%85%98-2-938634d86921)
+ [컴파일러 만들기](https://edykim.com/ko/post/the-super-tiny-compiler/)
+ [컴파일러에 대해서](https://gobae.tistory.com/94)
+ [컴파일러에 대해서2](https://trumanfromkorea.tistory.com/79)
+ [어휘, 구문, 의미 분석](https://chanto11.tistory.com/43)

