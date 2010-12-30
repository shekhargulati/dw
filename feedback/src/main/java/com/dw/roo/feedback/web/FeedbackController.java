package com.dw.roo.feedback.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.dw.roo.feedback.domain.Feedback;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "feedbacks", formBackingObject = Feedback.class)
@RequestMapping("/feedbacks")
@Controller
public class FeedbackController {
}
