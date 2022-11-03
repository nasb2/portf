package com.spring.portf.controller;

import com.spring.portf.domain.PictureDto;
import com.spring.portf.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {
    @Autowired
    PictureService pictureService;

    @RequestMapping("/")
    public String home(Model model) {
        try {
            List<PictureDto> list = pictureService.selectAll();
            model.addAttribute("list", list);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "home";
    }
}
