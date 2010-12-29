package com.dw.roo.conference.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.dw.roo.conference.domain.Speaker;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "speakers", formBackingObject = Speaker.class)
@RequestMapping("/speakers")
@Controller
public class SpeakerController {
}
