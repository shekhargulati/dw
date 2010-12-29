package com.dw.roo.conference.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.dw.roo.conference.domain.Talk;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "talks", formBackingObject = Talk.class)
@RequestMapping("/talks")
@Controller
public class TalkController {
}
