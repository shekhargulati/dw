package com.dw.roo.conference.web;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import com.dw.roo.conference.domain.Talk;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.mail.MailSender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;

@RooWebScaffold(path = "talks", formBackingObject = Talk.class)
@RequestMapping("/talks")
@Controller
public class TalkController {

    @Autowired
    private transient MailSender mailTemplate;

    @Autowired
    private transient SimpleMailMessage simpleMailMessage;

    public void sendMessage(String mailTo, String message) {
        simpleMailMessage.setTo(mailTo);
        simpleMailMessage.setText(message);
        mailTemplate.send(simpleMailMessage);
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid Talk talk, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("talk", talk);
            return "talks/create";
        }
        talk.persist();
        sendMessage(talk.getSpeaker().getEmail(),
                "Congrats you have successfully submitted your talk.\nOur team will review your submission and will get back to you shortly");
        return "redirect:/talks/" + encodeUrlPathSegment(talk.getId().toString(), request);
    }

    private String encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {
        }
        return pathSegment;
    }
}
