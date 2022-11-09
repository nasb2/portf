package com.spring.portf.controller;

import com.spring.portf.domain.PictureDto;
import com.spring.portf.service.PictureService;
import com.spring.portf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/pic")
public class PictureController {
    @Autowired
    PictureService pictureService;
    @Autowired
    UserService userService;

    // 필수항목 알림 메시지
    String fieldCheckMsg = "";

    // CRUD "patch"
    @PatchMapping("/picture/{pno}")
    @ResponseBody
    public String modify(PictureDto pictureDto, @PathVariable Integer pno, MultipartFile file, HttpSession session) {
        try {
            // 로그인 체크
            String id = (String) session.getAttribute("id");
            if (id == null) {
                return "LOGIN_REQ";
            }

            String filename = pictureDto.getFilename();
            // 이미지 수정사항 없으면 기존 이미지 파일이름 저장
            if (file == null) {
                pictureDto.setFilename(filename);
            } else {
                // 이미지 파일 수정한 경우
                uploadImageFile(file, pictureDto);
            }

            // 필드 널체크 & 제목에 "#" 부착
            if (!makeTagForTitle(pictureDto)) {
                return fieldCheckMsg;
            }

            // 수정된 정보를 DB에 입력
            pictureDto.setPno(pno);
            if (pictureService.update(pictureDto) != 1) {
                return "PATCH_FAILED";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "PATCH_OK";
    }

    // CRUD "delete"
    @DeleteMapping("/picture/{pno}")
    @ResponseBody
    public String delete(@PathVariable Integer pno, HttpSession session) {
        try {
            String id = (String) session.getAttribute("id");
            String writer = pictureService.read(pno).getWriter();

            if (id == null) {
                return "LOGIN_REQ";
            }

            if (pictureService.remove(pno, writer) == 1) {
                return "DELETE_OK";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "DELETE_FAILED";
    }

    // CRUD  "read"
    @GetMapping("/read")
    public String read(Integer pno, Model model, HttpSession session) {
        try {
            PictureDto pictureDto = pictureService.read(pno);
            model.addAttribute("pictureDto", pictureDto);

            String id = (String) session.getAttribute("id");
            String writer = pictureService.read(pno).getWriter();
            if (id != null && writer != null & equalsIdAndWriter(id, writer)) {
                model.addAttribute("samePerson", true);
            }

            // 이름 : 아이디 옆에 (이름) 띄우기
            String name = userService.select(writer).getName();
            model.addAttribute("name", name);

            // 작성일 : 등록일에서 현재까지 얼마나 지났는지 표현
            Date regDate = pictureDto.getRegDate();
            Date today = new Date();

            long diffSeconds = (today.getTime() / 1000) - (regDate.getTime() / 1000);
            long diffMinutes = (today.getTime() / (60 * 1000)) - (regDate.getTime() / (60 * 1000));
            long diffHours = (today.getTime() / (60 * 60 * 1000)) - (regDate.getTime() / (60 * 60 * 1000));
            long diffDays = (today.getTime() / (60 * 60 * 24 * 1000)) - (regDate.getTime() / (60 * 60 * 24 * 1000));

            String printTimeDiff = "";

            if (diffSeconds < 60) {
                printTimeDiff = "방금 전";
            } else if (diffMinutes < 60) {
                printTimeDiff = diffMinutes + "분 전";
            } else if (diffHours < 24) {
                printTimeDiff = diffHours + "시간 전";
            } else if (diffDays < 369) {
                printTimeDiff = diffDays + "일 전";
            } else {
                printTimeDiff = "오래된 글";
            }
            model.addAttribute("printTimeDiff", printTimeDiff);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "picture";
    }

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "6") Integer pageSize, Model model) {
        try {
            // 페이징 작업 (1~5까지 표시)
            int totalCnt = pictureService.selectCnt();
            PageHandler ph = new PageHandler(totalCnt, page, pageSize);
            ph.setBeginPage(page / (pageSize - 1) * (pageSize - 1) + 1);
            if (page % (pageSize - 1) == 0) {
                ph.setBeginPage((page - 1) / (pageSize - 1) * (pageSize - 1) + 1);
            }
            ph.setEndPage(Math.min(ph.getTotalPageCnt(), ph.getBeginPage() + 4));
            int endPage = ph.getEndPage();
            ph.setShowNext(endPage < ph.getTotalPageCnt());
            ph.setShowPrev(1 < ph.getBeginPage());
            model.addAttribute("ph", ph);
            List<PictureDto> list = pictureService.selectList((page - 1) * pageSize, pageSize);
            model.addAttribute("list", list);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "pictureList";
    }

    @GetMapping("/upload")
    public String upload(HttpSession session, HttpServletRequest request, Model model) {
        try {
            String id = (String) session.getAttribute("id");
            if (id == null) {
                model.addAttribute("msg", "LOGIN_REQ");
                request.setAttribute("url", request.getRequestURL());
            } else {
                model.addAttribute("mode", "mode_write");
                return "picture";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward:/login/login";
    }

    // CRUD  "write"
    @PostMapping("/upload")
    @ResponseBody
    public String upload(PictureDto pictureDto, MultipartFile file) {

        try {
            if (file == null || file.isEmpty()) {
                return "NO_IMAGE";
            }

            if (!makeTagForTitle(pictureDto)) {
                return fieldCheckMsg;
            }

            uploadImageFile(file, pictureDto);

            if (pictureService.write(pictureDto) != 1) {
                return "WRITE_FAILED";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "WRITE_SUCCESS";
    }

    // 로그인한 사람과 작성자 체크
    public boolean equalsIdAndWriter(String id, String writer) throws Exception {
        return id.equals(writer);
    }

    // 업로드한 이미지 파일 DB에 넣기 전처리
    public void uploadImageFile(MultipartFile file, PictureDto pictureDto) throws Exception {
        String filepath = "/img/";
//        String filepath = "/images/";
        String originalFilename = file.getOriginalFilename();
        UUID uuid = UUID.randomUUID();
        String filename = uuid + "_" + file.getOriginalFilename();

        File saveFile = new File(filename);
        file.transferTo(saveFile);

        pictureDto.setFilename(filename);
        pictureDto.setFilepath(filepath + filename);
        pictureDto.setOriginalFilename(originalFilename);
    }

    // 제목에 #태그 붙이는 메서드
    private boolean makeTagForTitle(PictureDto pictureDto) throws Exception {
        String title = pictureDto.getTitle() + "";
        String content = pictureDto.getContent();

        if ("undefined,".equals(title)) {
            fieldCheckMsg = "NO_CATEGORY";
            return false;
        } else if (title.length() < 4) {
            fieldCheckMsg = "NO_TITLE";
            return false;
        } else if (content == null || "".equals(content)) {
            fieldCheckMsg = "NO_CONTENT";
            return false;
        }

        String title1 = title.substring(0, 3);
        String title2 = title.substring(3);
        pictureDto.setTitle("#" + title1 + " #" + title2);
        return true;
    }
}