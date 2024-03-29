# 프로젝트 소개   

『오늘의사진』 - 사진 공유 게시판 개발 프로젝트   

<br>

AWS 비용 문제로 현재 서버 내린 상태입니다.

<br>

# 목차   
  
- 사용한 기술  
- 프로젝트 기획 의도  
- 프로젝트 핵심 기능  
  
  - 게시물 CRUD  
  - 페이징   
  - 키워드 검색
  - 댓글과 대댓글 구현
  - 이미지 파일 업로드 & 미리보기
  - 로그인 및 회원가입
- 트러블 슈팅 경험
- 프로젝트에 사용한 이미지 출처
- about me

<br>

## 개발 환경
-	IntelliJ
-	MySQL Workbench
-	Visual Studio Code
-	Windows 10

## 사용 기술
### Framework / Library
- JAVA 11 OpenJDK
- Spring Framework
- MyBatis
- jQuery
- Ajax
- REST API
- JSTL

### Build tool
- Maven

### Database
- MySQL

### Infra   
- AWS EC2 / RDS    

# 프로젝트 기획 의도
기본적인 게시판 구현 능력을 갖춘 이후, 웹 프로젝트를 기획하고 서버를 배포해보기로 했습니다.  
가장 공들여 연습한 파트인 게시판을 베이스로 여러 기능을 추가할 수 있는 『사진 공유 게시판 프로젝트』를 기획하게 되었습니다.

신입 다운 방법으로 역량을 어필하고 싶었기에 디자인이 서툴러도 완벽한 코드가 아니어도 
환경세팅부터 시작하여 설계, 구현, 디자인, 프로젝트 배포, 전부 스스로 제작하려고 노력했습니다.
단순 프로젝트 제작에 그치지 않고 지속적인 리팩토링과 추가 기능을 구현해 나갈 것을 약속합니다.  

추가 예정 기능 : 사진(유료) 구매 기능, 스프링 시큐리티, 전화번호 인증 기능 등   

# 프로젝트 핵심 기능
  ### 게시물 CRUD
  자유게시판과 사진게시판으로 분류하여 기본적인 CRUD를 구현하였습니다.  
  비회원인 경우에 게시물 읽기는 가능하나 글쓰기, 수정, 삭제 작업은 로그인한 회원만이 수행 가능하게 하였습니다. 
  사용자가 작성한 게시글에만 버튼이 활성화되도록 구현하였으며 특히 수정 버튼은 버튼 하나로 두 가지 작업을 수행하도록 재사용하였습니다.   
  
  ### 댓글과 대댓글 구현
  URL과 리소스 중심의 설계 방식인 REST API를 사용하였습니다. 또한 페이지 일부만을 변경하기 위해 Ajax 통신을 활용하였습니다.  
  Ajax 코드는 대부분 서버로부터 에러 코드를 받아와 해당 코드와 연결된 메시지를 출력하는 형태로 설계하였습니다. 
  실시간으로 댓글 수와 대댓글 수를 반영토록 구현하였습니다.
  
  ### 게시글 검색 기능
  검색창에 입력한 키워드가 제목 또는 내용에 포함돼 있다면 그에 맞는 검색 결과와 검색 결과 수를 함께 보여줍니다.
  
  ### 이미지 파일 업로드 & 미리보기 기능
  자유게시판과 마찬가지로 회원에게만 업로드, 수정, 삭제 권한이 부여됩니다. 업로드한 사진을 미리볼 수 있는 썸네일 기능을 구현하였고 
  ~~사진은 프로젝트 내부가 아닌 외부 폴더에 저장됩니다.~~   
  SNS 분위기를 내기 위해 #태그화 작업을 거치게 하고 작성날짜는 경과시간을 계산하여 “방금 전”, “2시간 전”으로 표시되게 구현해보았습니다.
  
  ### 로그인 및 회원가입
  로그인 중에는 상단의 회원가입 버튼이 아이디로 표시됩니다. 서버, 클라이언트 모두 유효성검사를 수행하되 서버단에서는 UserValidator를 구현한 뒤, 
  BindingResult 객체에 검증 결과를 담아 Properties 파일에서 해당하는 메시지를 보여주는 방식으로 구현하였습니다.  
  
  <br>
    
# 트러블 슈팅 경험
※ 블로그에 문제 해결 과정을 보다 자세히 정리했습니다.

- **원격서버 구축 & 프로젝트 배포 후 발견한 문제점 6가지**   
  아래 블로그 링크에 자세히 정리하였습니다.   
  https://blog.naver.com/devlearn/222924365771   
  이미지 파일 404 에러 해결 과정   
  https://blog.naver.com/devlearn/222924289708   

- **스프링 프로젝트 .war 파일 배포 404 에러**   
  The requested resource [/potf] is not available.    
  완성된 프로젝트를 war 파일로 추출하여 원격서버에 배포하는 과정에서 404 에러가 발생했습니다. 
  localhost:8080 으로 포트 연결은 정상적으로 되는데다, 로컬에서는 문제 없이 contextPath 로 접속되는 것을 보면 원격서버 리소스 매핑에 문제가 있다고 판단하였습니다.   
  contextPath 는 기본적으로 배포한 war 파일명으로 결정되기 때문에 war 파일명을 contextPath 와 일치시키든가
  ROOT.war 로 배포하는 방법으로 해결할 수 있었습니다.   

- **서브밋 후 뒤로가기 또는 F5새로고침 하면 이전 데이터가 남아있는 문제**   
  세션 기록 스택에 상태를 추가하는 history.pushState() 로 페이지 갱신없이 주소가 변경되도록 설정하였으나 간헐적으로 동일한 문제가 발생하여 
  form.reset() 을 적절히 조합하여 도중에 폼이 초기화되도록 처리해주었습니다.   
  (+파생 가능한 더블 서브밋 문제는 아이디 중복확인을 강제함으로써 해결했습니다.)   
  https://blog.naver.com/devlearn/222894893730   
  
- **외부 경로 이미지 엑박 문제**   
  보안상 접근이 불가능한 로컬 이미지를 웹브라우저에 띄우는 과정에서 어려움을 겪었습니다.   
  톰캣 설정 파일에서 docBase(실제경로)와 path(호출할 주소)를 선언해주면 되는 일이었으나 IntelliJ에서는 톰캣 서버가 내장되어 있으므로 일반적인 방법으로는 
  해결할 수 없었습니다. 톰캣 설정 파일에 직접 접근하여 설정코드를 입력하는 방법은 소용 없었으며 톰캣 Deployment 설정에서 외부 리소스 폴더를 추가하는 방법으로 해결할 수 있었습니다.   
  https://blog.naver.com/devlearn/222883950227   
  
- **검색결과 페이징 오류**   
  쿼리파라미터의 page 값이 검색결과페이지 수보다 클 경우에는 page 값을 1로 초기화해주었습니다.
  
- **쿼리스트링 jsessionid 로 인한 페이징 실패**   
  사용자가 쿠키를 허용하지 않은 상태에서 홈페이지를 이용할 경우 자동으로 따라 붙는 jsessionid 때문에 일부 기능에 차질이 발생한다는 사실을 발견했습니다.   
  해당 문제는 web.xml 파일에서 session-config 를 설정하면서 방지할 수 있었습니다.   
  https://blog.naver.com/devlearn/222898185494   

- **대댓글 입력폼 위치 오류**   
  본래 대댓글 입력폼은 자신의 상위요소에 따라붙게 되어있으나, 다음 상황에서는 페이지 맨 하단에 생성되는 문제를 발견했습니다.   
    - 대댓글이 1개 이상인 경우
    - 대댓글이 펼쳐진 상태
    - 원댓글에 대댓글 작성 버튼 클릭   
    
  이 경우 cno(댓글 번호)와 pcno(대댓글 번호)가 같은 경우와 다른 경우를 조건문으로 분기하여 서로 같은 경우에는 원댓글 아래로 폼이 이동하도록 처리했습니다.

- **중복 아이디로 회원가입 시도**   
  사용 가능한 아이디를 마지막에 이미 존재하는 아이디로 교묘히 변경하고 회원가입할 시 정상 처리된 것처럼 페이지가 이동되는 문제를 발견했습니다.   
  우선 유효성 검증 마지막에 중복확인 받은 아이디와 현재 입력된 아이디를 비교하도록 했습니다. 다를 경우, 중복확인 메서드를 강제하여 서버로부터 넘어오는 결과값이 1이 아니면 
  에러 메시지를 반환하게 처리했습니다.   
  
- **클릭 이벤트 중복 실행 문제**   
  하나의 버튼에 여러 번 이벤트를 걸었을 때 이벤트가 중첩되어 실행되는 현상이 발생했습니다.  
  불필요해진 클릭 이벤트는 한 번만 동작하도록 JQuery를 이용하여 이전의 클릭 이벤트는 off 해주었습니다.   
  
- **CommentDto 내 특정변수 기준으로 정렬**  
  기존 쿼리문을 변경하지 않고 CommentDto 내 특정변수 기준으로 내림차순 정렬이 필요했습니다. 이 경우 Stream 을 이용하여 컨트롤러단에서 간단히 해결하였습니다. 
  list=list.stream().sorted(Comparator.comparing(CommentDto::getComment_date).reversed()).collect(Collectors.toList());   
  https://blog.naver.com/devlearn/222858117792   

- **css 변경사항이 반영되지 않는 문제**   
  css 파일을 변경해도 디자인 적용이 되지 않는 문제가 발생한 적이 있습니다. 웹 서버가 브라우저 캐시에 이전 css 파일을 저장하고 불러오기 때문에 발생하는 문제입니다.
  웹 서버로 하여금 변경된 css 파일을 새로운 파일로 인식하도록 <link> 쿼리 스트링에 버전 정보를 붙여줌으로써 해결했습니다.   
  https://blog.naver.com/devlearn/222865966447   
    
- **게시판 XSS 공격 방어**   
  게시판 텍스트 영역에 스크립트 코드를 입력했을 때 스크립트가 그대로 실행되는 문제를 <c:out> 태그로 방어했습니다.   
  https://blog.naver.com/devlearn/222879625883
  
- **저절로 공백이 삽입되는 문제**   
  태그 textarea 에 입력한 내용 앞에 저절로 공백이 생기고 DB에 공백이 함께 입력되는 문제가 발생한 적이 있습니다. 코드를 reformat 하는 과정에서 자동으로 개행, 들여쓰기 되어
  발생하는 현상으로 <textarea> 여는 태그와 닫는 태그를 수평으로 놓음으로써 해결했습니다.  

- **페이지 틀이 깨져버리는 문제**   
  테스트 중에 게시판 제목이나 내용이 일정 글자 수를 초과하는 경우에 페이지 틀과 요소가 깨져버리는 현상이 발견되었습니다. 
  게시판 메인 페이지에서는 원본을 건드리지 않고 일부만 보여주면 되기에 컨트롤러단에서 substring() 으로 길이를 적절히 잘라서 Model에 저장되도록 처리했습니다.   
  https://blog.naver.com/devlearn/222904085442  
  
- **동적으로 생성된 버튼 먹통 현상**  
  document.ready() 안에다 댓글 삭제 버튼을 구현했으나 이벤트가 동작하지 않는 문제가 발생했습니다. document.ready() 는 페이지가 로드되는
  시점에 이미 존재하는 요소에만 이벤트를 걸 수 있기에 동적으로 생성된 요소를 구현하기 위해서는 고정된 요소에 이벤트를 걸어야 했습니다.   
  
<br>

# 프로젝트에 사용한 이미지 출처
- **픽사베이**     
https://pixabay.com/   
- **게티이미지뱅크**      
https://www.gettyimagesbank.com/   
픽사베이 사이트에서 이미지 소스를 가져와 사용하였으며 2차 수정·배포에 대한 저작권의 자유로움을 확인하였습니다.   
 
# about me   
백엔드 개발자 지망생 입니다.   
이메일 : nasb258@gmail.com   
블로그 : https://blog.naver.com/devlearn/   

**2021.08**    
  정보처리기사 취득   
**2022.04**    
  웹개발 공부 시작   
**2022.06**    
  SQLD 개발자 자격증, 리눅스 2급 취득   
**2022.09**    
  개인 프로젝트 기획, 설계, 구현, 디자인  
**2022.11**    
  개인 프로젝트 배포
